//
//  StopDetailViewCell.swift
//  BusRoutes
//
//  Created by Sharath Hiremath on 3/25/18.
//  Copyright © 2018 Sharath Hiremath. All rights reserved.
//

import UIKit

class StopDetailViewCell: UITableViewCell {

    //MARK: Properties
    @IBOutlet weak var stopImage: UIImageView!
    @IBOutlet weak var stopNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
