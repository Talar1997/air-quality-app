//
//  DetailsViewController.swift
//  AirQuality
//
//  Created by Talar on 18/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {

    @IBAction func BookmarkAction(_ sender: Any) {
        
    }
    
    @IBOutlet weak var TestLabel: UILabel!
    
    var station: Station?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TestLabel.text = station?.stationName

        // Do any additional setup after loading the view.
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
