//
//  ValueModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

struct ValueArray: Codable {
    var key: String
    var values: [ValueObject]
}

struct ValueObject: Codable {
    var date: String?
    var value: Double?
}
