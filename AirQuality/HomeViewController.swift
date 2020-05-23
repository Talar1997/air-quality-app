//
//  FirstViewController.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: UIViewController {
    @IBOutlet weak var NearlyOutlet: UIView!
    @IBOutlet weak var NearlyIndex: UILabel!
    @IBOutlet weak var NearlyNameLabel: UILabel!
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
        locationManager.delegate = self
        self.checkLocationServices()
    
        self.getStationArray()
        self.getUserLocation()
        self.findNearestStation()
        self.getNearestIndex()
        
        self.findBookmarkedStations()
        super.viewDidLoad()
        self.afterViewLoad()
    }
    
    func afterViewLoad(){
        NearlyOutlet.layer.borderWidth = 1
        NearlyOutlet.layer.borderColor = UIColor.systemBlue.cgColor
        NearlyOutlet.layer.cornerRadius = 8
        
        self.NearlyIndex.text = self.indexLevel?.stIndexLevel?.indexLevelName
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
    
    public func getUserLocation(){
        //
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
       /* let defaults = UserDefaults.standard
        guard let bookmarks = defaults.array(forKey: "bookmark") else { return }
        for stationId in bookmarks{
            for station in self.stations{
                //find station with stationId and append to array
                //for this array get index
            }
            self.getIndex(id: stationId as! Int)
        }*/
    }
    
    public func getIndex(id: Int){
        let indexController = IdentifiedDataFetchController(endpoint: EndpointList.index, idObject: id)
            let dataConverter = DictionaryPrepareController<IndexLevel>()
            
            let semaphore = DispatchSemaphore(value: 0)
            
            indexController.fetchAllData { (data, response, err) in
                let indexArray = dataConverter.prepareData(data: data)
                //append index to station array
                semaphore.signal()
            }
        
            semaphore.wait(timeout: .distantFuture)
    }
    
    public func getNearestIndex(){
        let indexController = IdentifiedDataFetchController(endpoint: EndpointList.index, idObject: self.nearestStation!.id)
        let dataConverter = DictionaryPrepareController<IndexLevel>()
        
        let semaphore = DispatchSemaphore(value: 0)
        
        indexController.fetchAllData { (data, response, err) in
            let indexArray = dataConverter.prepareData(data: data)
            self.indexLevel = indexArray[0]
            print(self.indexLevel)
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
}

extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else { return }
        self.userLocation = CLLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        print("Trying to get user location: ", self.userLocation, location)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
    
    
}

