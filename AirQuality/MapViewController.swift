//
//  SecondViewController.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    var stations = [Station]()

    @IBOutlet weak var mapView: MKMapView!
    
    let locationManager = CLLocationManager()
    let regionInMeter: Double = 20000;
    
    override func viewDidLoad() {
        getStationArray()
        mapView.delegate = self
        locationManager.delegate = self
        checkLocationServices()
        super.viewDidLoad()
    }
    
    public func getStationArray(){
        let stationsController = DataFetchController(endpoint: EndpointList.allStations)
        let dataConverter = DataPrepareController<Station>()
        
        stationsController.fetchAllData { (data, response, err) in
            self.stations = dataConverter.prepareData(data: data)
            self.assignStations(arrayOfStations: self.stations)
        }
    }
    
    public func assignStations(arrayOfStations: [Station]){
        stations = arrayOfStations
        setPinsOnMap()
    }
    
    public func setPinsOnMap(){
        self.stations.forEach { (station) in
            addPin(station: station)
        }
    }
    
    func addPin(station: Station){
        let stationAnnotation = CustomPinModel()
        stationAnnotation.coordinate = CLLocationCoordinate2D(latitude: Double(station.gegrLat)!, longitude: Double(station.gegrLon)!)
        stationAnnotation.title = station.stationName
        stationAnnotation.station = station
        
        self.mapView.addAnnotation(stationAnnotation)
    }
    
    func setupLocationManager(){
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
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
    
    func centerViewOnUserLocation(){
        if let location = locationManager.location?.coordinate{
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func checkLocationAuthorization(){
        switch CLLocationManager.authorizationStatus() {
        case .authorizedAlways:
            //allows even if app in background
            //do map stuff
            break
        case .authorizedWhenInUse:
            //allows when app is in use
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
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

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, latitudinalMeters: regionInMeter, longitudinalMeters: regionInMeter)
        mapView.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsViewController
        
        guard let customPin = view.annotation as? CustomPinModel else { return }
        vc?.station = customPin.station
        self.navigationController?.pushViewController(vc!, animated: true)
        
    }
}
