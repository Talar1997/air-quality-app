//
//  CityModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

public class CityModel {
    init(json: [String: Any]){
        id = json["id"] as? Int ?? -1
        name = json["name"] as? String ?? ""
        communeName = json["communeName"] as? String ?? ""
        districtName = json["districtName"] as? String ?? ""
        proviceName = json["proviceName"] as? String ?? ""
    }
    
    var id: Int = -1
    var name: String = ""
    var communeName: String = ""
    var districtName: String = ""
    var proviceName: String = ""
}
