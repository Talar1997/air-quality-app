//
//  DataFetchController.swift
//  AirQuality
//
//  Created by Talar on 19/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class DataFetchController: DataFetchProtocol {
    var endpoint: String
    
    init(endpoint: String){
        self.endpoint = endpoint
    }
    
    func fetchAllData(completion: @escaping (Data?, URLResponse?, Error?) -> ()){
        let jsonUrlString = self.endpoint
        let url = URL(string: jsonUrlString)
        
        URLSession.shared.dataTask(with: url!){ (data, res, err) in
            completion(data, res, err)
        }.resume()
    }
    

}
