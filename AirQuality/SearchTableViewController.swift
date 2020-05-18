//
//  SearchTableViewController.swift
//  AirQuality
//
//  Created by Talar on 15/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchControllerDelegate, UISearchBarDelegate {

    var stations = [Station]()
    var allStations = [Station]()
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        getStationArray()
        searchBarSetup()
        super.viewDidLoad()
    }
    
    private func searchBarSetup(){
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Szukaj stacji pomiarowych"
        searchController.searchBar.setValue("Anuluj", forKey: "cancelButtonText")
        self.navigationItem.searchController = searchController
    }
    
    public func getStationArray(){
        let stationsController = StationsController()
        
        stationsController.fetchAllStations { (data, response, err) in
            self.stations = stationsController.prepareData(data: data)
            self.allStations = self.stations
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.stations.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "stationCell", for: indexPath) as? DetailsTableViewCell
        
        cell?.textLabel!.text = stations[indexPath.row].stationName
        cell?.station = stations[indexPath.row]

        return cell!
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "detailsView") as? DetailsViewController
        vc?.station = stations[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }

}

extension SearchTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if searchText == "" {
            stations = allStations
        } else {
            stations = allStations
            stations = stations.filter{
                $0.stationName.contains(searchText)
            }
        }
        tableView.reloadData()
    }
}
