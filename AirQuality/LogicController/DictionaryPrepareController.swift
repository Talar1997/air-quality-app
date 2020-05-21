//
//  DictionaryPrepareController.swift
//  AirQuality
//
//  Created by Talar on 20/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class DictionaryPrepareController<T:Codable> {
    func prepareData(data: Data?) -> [T]{
        var result = [T]()
        guard let data = data else { return [T]() }
        
        do{
            //print(try? JSONSerialization.jsonObject(with: data, options: .mutableContainers)) //for debug
            result.append(try JSONDecoder().decode(T.self, from: data))
        } catch let jsonErr {
            print("Parsing error: ", jsonErr)
        }
        
        return result
    }
}
