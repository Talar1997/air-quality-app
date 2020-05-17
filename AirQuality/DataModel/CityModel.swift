//
//  CityModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

struct City: Codable{
    var id: Int
    var name: String
    var commune: Commune
}
