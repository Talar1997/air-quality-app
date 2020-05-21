//
//  EndpointList.swift
//  AirQuality
//
//  Created by Talar on 19/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

struct EndpointList{
    static let allStations = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
    static let index = "http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/"  //{idStation}
    static let sensors = "http://api.gios.gov.pl/pjp-api/rest/station/sensors/" //{idStation}
    static let sensorValue = "http://api.gios.gov.pl/pjp-api/rest/data/getData/" //{idSensor}
}
