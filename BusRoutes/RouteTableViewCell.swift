//
//  RouteTableViewCell.swift
//  BusRoutes
//
//  Created by Sharath Hiremath on 3/21/18.
//  Copyright © 2018 Sharath Hiremath. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {

    //MARK: Properties
    
    @IBOutlet weak var routeLabel: UILabel!
    @IBOutlet weak var routeImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
