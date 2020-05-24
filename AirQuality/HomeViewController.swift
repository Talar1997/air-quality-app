//
//  FirstViewController.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    @IBOutlet weak var NearlyOutlet: UIView!
    @IBOutlet weak var NearlyIndex: UILabel!
    @IBOutlet weak var NearlyNameLabel: UILabel!
    @IBOutlet weak var TableViewOutlet: UITableView!
    
    @IBAction func ViewDetails(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsViewController
        
        let station = nearestStation
        vc?.station = station
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    var userLocation: CLLocation?
    var stations = [Station]()
    var nearestStation: Station?
    var bookmarkedStations = [Station]()
    let locationManager = CLLocationManager()
    var indexLevel: IndexLevel?

    override func viewDidLoad() {
        TableViewOutlet.delegate = self
        TableViewOutlet.dataSource = self
        locationManager.delegate = self
        self.checkLocationServices()
    
        self.getStationArray()
        self.findNearestStation()
        self.getNearestIndex()
        
        self.reloadBookmarks()
        super.viewDidLoad()
        self.afterViewLoad()
        self.TableViewOutlet.reloadData()
    }
    
    func reloadBookmarks(){
        self.findBookmarkedStations()
        self.TableViewOutlet.reloadData()
    }
    
    func afterViewLoad(){
        NearlyOutlet.layer.borderWidth = 1
        NearlyOutlet.layer.borderColor = UIColor.systemBlue.cgColor
        NearlyOutlet.layer.cornerRadius = 8
        
        self.NearlyIndex.text = "Jakość powietrza: " + (self.indexLevel?.stIndexLevel!.indexLevelName)!
        self.NearlyNameLabel.text = self.nearestStation?.stationName
    }
    
    public func getStationArray(){
        let stationsController = DataFetchController(endpoint: EndpointList.allStations)
        let dataConverter = DataPrepareController<Station>()
        
        let semaphor = DispatchSemaphore.init(value: 0)
        stationsController.fetchAllData { (data, response, err) in
            self.stations = dataConverter.prepareData(data: data)
            semaphor.signal()
        }
        semaphor.wait(timeout: .distantFuture)
    }
    
    public func findNearestStation(){
        var smallestDistance: CLLocationDistance?
        
        for station in stations{
            let lat = Double(station.gegrLat)!
            let lon = Double(station.gegrLon)!
            let stationLocation = CLLocation(latitude: lat, longitude: lon)
            let distance = self.userLocation?.distance(from: stationLocation)
            
            //print("Considering: ", station.stationName, " distance btwn user loc: ", distance)
            if(smallestDistance == nil || distance! < smallestDistance!){
                //print("^^^Now nearest")
                self.nearestStation = station
                smallestDistance = distance
            }
        }
    }
    
    public func findBookmarkedStations(){
       let defaults = UserDefaults.standard
        guard let bookmarks = defaults.array(forKey: "bookmarks") else { return }
        for stationId in bookmarks{
            for station in self.stations{
                if(station.id == stationId as! Int){
                    bookmarkedStations.append(station)
                    break
                }
            }
        }
    }
    
    public func getIndex(id: Int) -> String{
        var index = "Brak indeksu"
        
        let indexController = IdentifiedDataFetchController(endpoint: EndpointList.index, idObject: id)
            let dataConverter = DictionaryPrepareController<IndexLevel>()
            
            let semaphore = DispatchSemaphore(value: 0)
            
            indexController.fetchAllData { (data, response, err) in
                let indexArray = dataConverter.prepareData(data: data)
                index = indexArray[0].stIndexLevel?.indexLevelName as! String
                semaphore.signal()
            }
        
            semaphore.wait(timeout: .distantFuture)
        return index
    }
    
    public func getNearestIndex(){
        let indexController = IdentifiedDataFetchController(endpoint: EndpointList.index, idObject: self.nearestStation!.id)
        let dataConverter = DictionaryPrepareController<IndexLevel>()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        indexController.fetchAllData { (data, response, err) in
            let indexArray = dataConverter.prepareData(data: data)
            self.indexLevel = indexArray[0]
            //print(self.indexLevel)
            semaphore.signal()
        }
    
        semaphore.wait(timeout: .distantFuture)
    }
    
    func checkLocationServices(){
        if CLLocationManager.locationServicesEnabled(){
            setupLocationManager()
            checkLocationAuthorization()
        }
        else{
            //some alert
        }
    }
    
    func setupLocationManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            //allows even if app in background
            //do map stuff
            break
        case .authorizedWhenInUse:
            self.userLocation = locationManager.location
            //allows when app is in use
            break
        case .denied:
            //User need to change location in settings
            break
        case .restricted:
            //Restricted means user location can be disabled by some policy (eg. parental control)
            //User cannot change this status
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        @unknown default:
            break
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.bookmarkedStations.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookmarkedCell", for: indexPath) as! FavTableViewCell
        
        cell.NameLabel.text = self.bookmarkedStations[indexPath.row].stationName
        cell.IndexLabel.text = self.getIndex(id: self.bookmarkedStations[indexPath.row].id)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsViewController
        
        let station = bookmarkedStations[indexPath.row]
        vc?.station = station
        self.navigationController?.pushViewController(vc!, animated: true)
        tableView.reloadData()
    }

}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else { return }
        self.userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
}

