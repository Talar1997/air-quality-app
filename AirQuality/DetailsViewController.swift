//
//  DetailsViewController.swift
//  AirQuality
//
//  Created by Talar on 18/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBOutlet weak var PMOutlet: UIView!
    @IBOutlet weak var PM10Outlet: UIView!
    @IBOutlet weak var SO2Outlet: UIView!
    @IBOutlet weak var NO2Outlet: UIView!
    @IBOutlet weak var COOutlet: UIView!
    @IBOutlet weak var C6H6Outlet: UIView!
    @IBOutlet weak var O3Outlet: UIView!
    
    @IBOutlet weak var IndexNameLabel: UILabel!
    @IBOutlet weak var StationNameLabel: UILabel!
    @IBOutlet weak var PM25Label: UILabel!
    @IBOutlet weak var PM10Label: UILabel!
    @IBOutlet weak var SO2Label: UILabel!
    @IBOutlet weak var NO2Label: UILabel!
    @IBOutlet weak var COLabel: UILabel!
    @IBOutlet weak var C6H6Label: UILabel!
    @IBOutlet weak var O3Label: UILabel!
    
    @IBAction func BookmarkAction(_ sender: Any) {
        print("bookmark performed")
    }
    
    public var station: Station?
    public var indexLevel: IndexLevel?
    var sensorList = [Sensor]()
    var sensorValueList = [ValueArray]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.beforeViewLoad()
        self.afterViewLoad()
        
    }
    
    func beforeViewLoad(){
        self.getIndexLevel()
        self.getSensors()
    }
    
    func afterViewLoad(){
        StationNameLabel.text = self.station?.stationName
        IndexNameLabel.text = self.indexLevel?.stIndexLevel?.indexLevelName
        
        self.formatOutlet(elements: [PMOutlet, PM10Outlet, SO2Outlet, NO2Outlet, COOutlet, C6H6Outlet, O3Outlet])
    }
    
    func formatOutlet(elements: [UIView]){
        for element in elements{
            element.layer.borderWidth = 1
            element.layer.borderColor = UIColor.systemBlue.cgColor
            element.layer.cornerRadius = 8
        }
    }
    
    func getIndexLevel(){
        let indexController = IdentifiedDataFetchController(endpoint: EndpointList.index, idObject: station!.id)
        let dataConverter = DictionaryPrepareController<IndexLevel>()
        
        let semaphore = DispatchSemaphore(value: 0)
        indexController.fetchAllData { (data, response, err) in
            let indexArray = dataConverter.prepareData(data: data)
            self.indexLevel = indexArray[0]
            semaphore.signal()
        }
        semaphore.wait(timeout: .distantFuture)
    }
    
    func getSensors(){
        let sensorsController = IdentifiedDataFetchController(endpoint: EndpointList.sensors, idObject: station!.id)
        let dataConverter = DataPrepareController<Sensor>()
        
        sensorsController.fetchAllData{ (data, response, err) in
            self.sensorList = dataConverter.prepareData(data: data)
            self.getSensorValues()
        }
    }
    
    func getSensorValues(){
        let dataConverter = DictionaryPrepareController<ValueArray>()
        self.sensorList.forEach{ sensor in
            let sensorValueController = IdentifiedDataFetchController(endpoint: EndpointList.sensorValue, idObject: sensor.id)
            sensorValueController.fetchAllData{ (data, response, err) in
                self.sensorValueList = dataConverter.prepareData(data: data)
                print(self.sensorValueList)
            }
            
        }
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
