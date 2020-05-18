//
//  SensorsController.swift
//  AirQuality
//
//  Created by Talar on 18/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class SensorsController {
    var idStation: Int = -1
    
    init(idStation: Int){
        print("Sensor Controller initializated")
        self.idStation = idStation
    }
    
    func fetchSensors(completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let jsonUrlString = "http://api.gios.gov.pl/pjp-api/rest/sensors/\(idStation)"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){ (data, res, err) in
            completion(data, res, err)
        }.resume()
    }
    
    func prepareData(data: Data?) -> [Sensor]{
        var result = [Sensor]()
        guard let data = data else {
            return [Sensor]()
        }
        
        do{
            result = try JSONDecoder().decode([Sensor].self, from: data)
        } catch let jsonErr {
            print("Error: ", jsonErr)
        }
        
        return result
    }
    
}
