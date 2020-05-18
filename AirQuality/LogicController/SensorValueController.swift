//
//  SensorValueController.swift
//  AirQuality
//
//  Created by Talar on 19/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class SensorValueController {
    var idSensor: Int = -1
    
    init(idSensor: Int){
        print("Sensor Controller initializated")
        self.idSensor = idSensor
    }
    
    func fetchValues(completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let jsonUrlString = "http://api.gios.gov.pl/pjp-api/rest/getData/\(idSensor)"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){ (data, res, err) in
            completion(data, res, err)
        }.resume()
    }
    
    func prepareData(data: Data?) -> [ValueArray]{
        var result = [ValueArray]()
        guard let data = data else {
            return [ValueArray]()
        }
        
        do{
            result = try JSONDecoder().decode([ValueArray].self, from: data)
        } catch let jsonErr {
            print("Error: ", jsonErr)
        }
        
        return result
    }
}
