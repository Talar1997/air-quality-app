//
//  SearchViewController.swift
//  AirQuality
//
//  Created by Talar on 13/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

struct Commune: Codable{
    var communeName: String
    var districtName: String
    var provinceName: String
}

struct City: Codable{
    var id: Int
    var name: String
    var commune: Commune
}

struct Station: Codable {
    var id: Int
    var stationName: String
    var gegrLat: String
    var gegrLon: String
    var city: City
    var addressStreet: String?
}

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        
        let jsonUrlString = "http://api.gios.gov.pl/pjp-api/rest/station/findAll"
        guard let url = URL(string: jsonUrlString) else { return }
        
        URLSession.shared.dataTask(with: url){ (data, response, error) in
            guard let data = data else { return }
            
            do{
                let stations = try JSONDecoder().decode([Station].self, from: data)
                print(stations) 
            } catch let jsonErr {
                print("Error: ", jsonErr)
            }
        }.resume()
    }
}
