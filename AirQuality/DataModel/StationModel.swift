//
//  StationModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

public class StationModel {
    init(json: [String: Any]){
        id = json["id"] as? Int ?? -1
        stationName = json["stationName"] as? String ?? ""
        gegrLat = json["gegrLat"] as? Double ?? -1
        gegrLon = json["gegrLon"] as? Double ?? -1
        //city = CityModel(json["city"])
        addressStreet = json["addressString"] as? String ?? ""
    }
    
    var id: Int = -1
    var stationName: String = ""
    var gegrLat: Double = 0.0
    var gegrLon: Double = 0.0
    //var city: CityModel = CityModel(json: <#[String : Any]#>)
    var addressStreet: String?
    
    //each station has own Sensors:
    var listOfSensors = Array<SensorModel>()
    
    func getSensors(){
        
    }
    
}
