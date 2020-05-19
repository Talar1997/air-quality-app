//
//  DataFetchController.swift
//  AirQuality
//
//  Created by Talar on 19/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class IdentifiedDataFetchController: DataFetchController {
    var idObject: Int
    
    init(endpoint: String, idObject: Int){
        self.idObject = idObject
        super.init(endpoint: endpoint)
        self.endpoint = endpoint + String(idObject)
    }

}
