//
//  StationModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class StationModel: NSObject {
    override init(){
        NSLog("Init Station")
    }
    
    var id: Int = 0
    var stationName: String = ""
    var gegrLat: Double = 0.0
    var gegrLon: Double = 0.0
    var city: CityModel = CityModel()
    var addressStreet: String?
    
    //each station has own Sensors:
    var listOfSensors = Array<SensorModel>()
    
    func getSensors(){
        
    }
    
}
