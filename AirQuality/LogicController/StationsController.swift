//
//  StationsController.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit
import Foundation

struct Commune: Codable{
    let communeName: String
    let districtName: String
    let proviceName: String
}

struct City: Codable{
    let id: Int
    let name: String
    let commune: Commune
}

struct Station: Codable {
    let id: Int
    let stationName: String
    let gegrLat: Double
    let gegrLon: Double
    let city: City
    let addressStreet: String?
}

struct Stations: Codable {
    var results: [Station]
}

public class StationsController {
    init(){
        print("Init All Stations")
    }
    
    public func getAllStations(){
        let allStations = [Station]()
        
        let url = URL(string: "http://api.gios.gov.pl/pjp-api/rest/station/findAll")!
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data {
                let stations = try? JSONDecoder().decode([Station].self, from: data)
                print(stations) //nil
                
            }
        }.resume()
    }
}
