//
//  DataPrepareController.swift
//  AirQuality
//
//  Created by Talar on 19/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class DataPrepareController<T:Codable> {
    func prepareData(data: Data?) -> [T]{
        var result = [T]()
        guard let data = data else { return [T]() }
        
        do{
            result = try JSONDecoder().decode([T].self, from: data)
        } catch let jsonErr {
            print("Parsing error: ", jsonErr)
        }
        
        return result
    }
}
