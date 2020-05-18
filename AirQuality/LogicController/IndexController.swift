//
//  IndexController.swift
//  AirQuality
//
//  Created by Talar on 18/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class IndexController {
    var idStation: Int = -1
    
    init(idStation: Int){
        print("Index Controller initializated")
        self.idStation = idStation
    }
    
    func fetchIndex(completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let jsonUrlString = "http://api.gios.gov.pl/pjp-api/rest/getIndex/\(idStation)"
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){ (data, res, err) in
            completion(data, res, err)
        }.resume()
    }
    
    func prepareData(data: Data?) -> [IndexLevel]{
        var result = [IndexLevel]()
        guard let data = data else {
            return [IndexLevel]()
        }
        
        do{
            result = try JSONDecoder().decode([IndexLevel].self, from: data)
        } catch let jsonErr {
            print("Error: ", jsonErr)
        }
        
        return result
    }
    
}
