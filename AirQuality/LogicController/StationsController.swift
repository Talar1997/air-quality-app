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
        print("Stations Controller initializated")
    }
    
    func fetchAllStations(completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let jsonUrlString = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){ (data, res, err) in
            completion(data, res, err)
        }.resume()
    }
    
    func prepareData(data: Data?) -> [Station]{
        var result = [Station]()
        guard let data = data else {
            print("No data")
            return [Station]()
        }
        
        do{
            result = try JSONDecoder().decode([Station].self, from: data)
        } catch let jsonErr {
            print("Error: ", jsonErr)
        }
        
        return result
    }
    
}
