//
//  ParamModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class ParamModel: NSObject {
    override init(){
        NSLog("Init Station")
    }
    
    var idParam: Int = 0
    var paramName: String = ""
    var paramFormula: String = ""
    var paramCode: String = ""
    
    //each param have own value where value.key === paramFormula
    var listOfValues = Array<ValueModel>()
    
    func getValues(){
        
    }
}
