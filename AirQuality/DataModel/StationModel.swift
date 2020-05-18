//
//  StationModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

struct Station: Codable {
    var id: Int
    var stationName: String
    var gegrLat: String
    var gegrLon: String
    var city: City
    var addressStreet: String?
}

struct City: Codable{
    var id: Int
    var name: String
    var commune: Commune
}

struct Commune: Codable{
    var communeName: String
    var districtName: String
    var provinceName: String
}
