//
//  ValueModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class ValueModel: NSObject {
    override init(){
        NSLog("Init Station")
    }
    
    var key: String = ""
    var values = [String : Double]()
}
