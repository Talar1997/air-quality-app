//
//  SearchViewController.swift
//  AirQuality
//
//  Created by Talar on 13/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchController = UISearchController(searchResultsController: nil)
        self.navigationItem.searchController = searchController
        self.getStations();
        // Do any additional setup after loading the view.
    }
    
    func getStations(){
        let stationsController = StationsController()
        stationsController.getAllStations()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
