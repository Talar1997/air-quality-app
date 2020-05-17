//
//  StationsController.swift
//  AirQuality
//
//  Created by Talar on 11/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit
import Foundation



public class StationsController {
    var stations = [Station]()
    
    init(){
        print("Init All Stations")
    }
    
    func getAllStations() -> [Station]{
        var result = [Station]()
        let jsonUrlString = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){ (data, response, error) in
            guard let data = data else { return }
            
            do{
                self.stations = try JSONDecoder().decode([Station].self, from: data)
                result = self.stations
                print("im here")
                print(result)
            } catch let jsonErr {
                print("Error: ", jsonErr)
            }
        }.resume()
        
        return result
    }
    
}
