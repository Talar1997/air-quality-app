//
//  IndexModel.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

struct IndexLevel: Codable {
    var id: Int
    
    var stCalcDate: String?
    var stIndexLevel: StIndexLevel?
    var stSourceDataDate: String?
    var stIndexStatus: Bool?
    var stIndexCrParam: String?
}

struct StIndexLevel: Codable{
    var id: Int
    var indexLevelName: String
}
