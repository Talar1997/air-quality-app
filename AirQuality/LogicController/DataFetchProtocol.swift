//
//  DataFetchProtocol.swift
//  AirQuality
//
//  Created by Talar on 19/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

protocol DataFetchProtocol {
    var endpoint: String { get set }
    
    func fetchAllStations(completion: @escaping (Data?, URLResponse?, Error?) -> ()) -> Void
}
