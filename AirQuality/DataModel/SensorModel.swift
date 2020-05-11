//
//  SensorModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class SensorModel: NSObject {
    override init(){
        NSLog("Init Station")
    }
    
    var id: Int = 0
    var stationId: Int = 0
    
    //each sensor can provide own parameters
    var listOfParams = Array<ParamModel>()
    
    func getParams(){
        
    }
}
