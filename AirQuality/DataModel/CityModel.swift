//
//  CityModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class CityModel: NSObject {
    override init(){
        NSLog("Init Station")
    }
    
    var id: Int = 0
    var name: String = ""
    var communeName: String = ""
    var districtName: String = ""
    var proviceName: String = ""
}
