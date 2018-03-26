//
//  RouteDetailsTableViewController.swift
//  BusRoutes
//
//  Created by Sharath Hiremath on 3/23/18.
//  Copyright © 2018 Sharath Hiremath. All rights reserved.
//

import UIKit
import os.log

class RouteDetailsTableViewController: UITableViewController {
    
    //MARK: Properties
    var route: Route?
    let accessibilityIcon = UIImage(named: "accessibilityIcon")
    var routeIndex: Int?
    let line = UIImage(named: "verticalLineIcon")
    let dot = UIImage(named: "dotIcon")

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.backItem?.title = " "
        self.tableView.backgroundColor = UIColor.groupTableViewBackground
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (route?.stops.count)!
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "StopDetailCell"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
        cell.textLabel?.text = route?.stops[indexPath.row]
        let backgroundImage = UIColor.groupTableViewBackground.image(CGSize(width: 45, height: 45))
        cell.imageView?.image = backgroundImage
        cell.imageView?.addSubview(getStopImage(index: indexPath.row))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        // Create a view for the header section
        let view = UIView()
        
        //TODO: Move this logic to another class
        let routeImage = UIImageView(image: route?.photo)
        
        // Add the Route image
        view.addSubview(routeImage)
        routeImage.frame = CGRect(x: 8, y: 8, width: 100, height: 100)
        
        // Add route name
        let routeNameLabel = UILabel()
        routeNameLabel.text = route?.name
        routeNameLabel.frame = CGRect(x: 116, y: 8, width: 180, height: 45)
        view.addSubview(routeNameLabel)
        
        // Add accesibility icon if accessible
        // TODO: Fix the acessibility to right
        if (route?.isAccessible == true) {
            let accessibilityImage = UIImageView(image: accessibilityIcon)
            accessibilityImage.frame = CGRect(x: 320, y: 8, width: 45, height: 45)
            view.addSubview(accessibilityImage)
        }
        
        // Add Description
        let routeDescLabel = UILabel()
        routeDescLabel.text = route?.description
        routeDescLabel.numberOfLines = 0
        routeDescLabel.font = UIFont.systemFont(ofSize: 13.0)
        routeDescLabel.frame = CGRect(x: 116, y: 61, width: 300, height: 45)
        routeDescLabel.sizeToFit()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.addSubview(routeDescLabel)
        
        return view
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 116
    }
    
    //MARK: Private Methods
    private func getStopImage(index: Int) -> UIImageView {
        // TODO: Replace with a custom cell implementation
        let line = UIImage(named: "verticalLineIcon")
        let lineImageView = UIImageView(image: line)
        let lineWidth = 5.0
        let lineHeight = 43.5 * 3
        let lineX = 19.50
        let lineY = -43.5
        lineImageView.frame = CGRect(x: lineX, y:lineY, width:lineWidth, height: lineHeight)
        
        let dot = UIImage(named: "dotIcon")
        let dotImageView = UIImageView(image: dot)
        let dotWidth = 20.0
        let dotHeight = 40.0
        let dotX = -((dotWidth / 2.0) - (lineWidth / 2.0))
        var dotY = -(lineY + ((43.5 - dotHeight) / 2.0))   //49.25
        
        if index == 0 {
            // For top stop
            dotY = -lineY - ((dotHeight - dotWidth) / 2.0)
            os_log("Top: Dot Y is ", dotY)
        } else if index == ((route?.stops.count)! - 1){
            dotY = -(2 * lineY) - (dotHeight - (dotWidth / 2.0))
            os_log("Bottom: Dot Y is ", dotY)
        } else {
            // For centre stop
            dotY = -(1.5 * lineY) - (dotHeight / 2.0)
            os_log("Centre: Dot Y is ", dotY)
        }
        
        dotImageView.frame = CGRect(x: dotX, y: dotY, width: dotWidth, height:dotHeight)
        // Add the dot on top of line
        lineImageView.addSubview(dotImageView)
       
        return lineImageView
    }

}

extension UIColor {
    // Function to get a square image of solid colour
    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height))
        }
    }
}
