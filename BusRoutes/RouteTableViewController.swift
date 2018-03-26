//
//  RouteTableViewController.swift
//  BusRoutes
//
//  Created by Sharath Hiremath on 3/21/18.
//  Copyright © 2018 Sharath Hiremath. All rights reserved.
//

import UIKit
import os.log

class RouteTableViewController: UITableViewController {
    
    //MARK: Properties
    
    var routes = [Route]()
    
    var pageViewController : UIPageViewController!
    
    let busDataURL = URL(string: "http://www.mocky.io/v2/5a0b474a3200004e08e963e5")
    

    
    var parsedRoutes = [Route]()

    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationItem.title = "Routes"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return routes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RouteTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RouteTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RouteTableViewCell.")
        }
        
        // Fetches the appropriate route for the data source layout.
        let route = routes[indexPath.row]

        // Configure the cell...
        cell.routeLabel.text = route.name
        if let imageToLoad = route.photo {
            cell.routeImageView.image = imageToLoad
        }
        return cell
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        navigationItem.title = " "
        guard let routeViewController = segue.destination as? ViewController else {
            fatalError("Unexpected destination: \(segue.destination)")
        }
        
        guard let selectedRouteCell = sender as? RouteTableViewCell else {
            fatalError("Unexpected sender: \(sender)")
        }
        
        guard let indexPath = tableView.indexPath(for: selectedRouteCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
//        let selectedRoute = routes[indexPath.row]
        routeViewController.routes = routes
        routeViewController.currentRouteIndex = indexPath.row
        
    }
    
    //MARK: Private Methods
    private func loadData() {
        let task = URLSession.shared.dataTask(with: busDataURL!) {(data, response, error ) in
            
            guard error == nil else {
                os_log("Error: Couldn't reach Bus Data API")
                return
            }
            
            guard let content = data else {
                os_log("Error: No data received from Bus Data API")
                return
            }
            
            guard let dataArray = (try? JSONSerialization.jsonObject(with: content, options: [])) as? [Any] else {
                os_log("Error: Not valid JSON")
                return
            }
            
            for item in dataArray {
                guard let dataItem = item as? [String: Any] else {
                    os_log("Error: Invalid Data Item")
                    return
                }
                let route = try? Route(json: dataItem)
                self.parsedRoutes.append(route!)
                self.routes.append(route!)
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
        }
        task.resume()
    }

}
