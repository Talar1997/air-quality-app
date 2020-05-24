//
//  FavTableViewCell.swift
//  AirQuality
//
//  Created by Talar on 24/05/2020.
//  Copyright © 2020 Talarczyk. All rights reserved.
//

import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var NameLabel: UILabel!
    @IBOutlet weak var IndexLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
