//
//  Route.swift
//  BusRoutes
//
//  Created by Sharath Hiremath on 3/21/18.
//  Copyright © 2018 Sharath Hiremath. All rights reserved.
//

import UIKit

class Route {
    
    //MARK: Properties
    var id: String
    var isAccessible: Bool
    var photo: UIImage?
    var name: String
    var description: String
    var stops: [String]
    
    let busStopPlaceHolderIcon = UIImage(named: "busStopPlaceHolder")
    
    //MARK: Initialization
    
    init(id: String, name: String, imageURL: String?, description: String, isAccessible: Bool, stops: [String]) {
        // Initialize stored properties.
        self.id = id
        self.name = name
        self.description = description
        self.isAccessible = isAccessible
        self.stops = stops
        
        //TODO: Async Download to improve performance
        if let imageString = imageURL {
            let url = URL(string: imageString)
            let data = try? Data(contentsOf: url!)
            self.photo = UIImage(data: data!)
        } else {
            print("Image URL is nil")
        }
        
    }
    
    init(json: [String: Any]) throws {
        // Extract id
        guard let id = json["id"] as? String else {
            throw SerializationError.missing("id")
        }
        self.id = id
        
        // Extract accessibility
        guard let isAccessible = json["accessible"] as? Bool else {
            throw SerializationError.missing("accessibility property")
        }
        self.isAccessible = isAccessible
        
        // Extract stop name
        guard let name = json["name"] as? String else {
            throw SerializationError.missing("name")
        }
        self.name = name
        
        // TODO: async image loading
        // Extract imageURL and set image
        if let imageString = json["imageUrl"] as? String {
            print("Image URL  for \(name) is \(imageString)")
            let url = URL(string: imageString)
            if let data = (try? Data(contentsOf: url!)){
                self.photo = UIImage(data: data)
            } else {
                print("Error retrieving image from \(imageString)")
                self.photo = busStopPlaceHolderIcon
            }
        } else {
            print("Image URL for \(name) is nil")
            self.photo = busStopPlaceHolderIcon
        }
        
      
        // Extract stop description
        guard let description = json["description"] as? String else {
            throw SerializationError.missing("description")
        }
        self.description = description
        
        // Extract and validate meals
        guard let stops = json["stops"] as? [Dictionary<String, String>] else {
            throw SerializationError.missing("stops")
        }
        
        var busStops = [String]()
        for stp in stops {
            guard let stop = stp["name"] else {
                throw SerializationError.missing("stop")
            }
            
            busStops.append(stop)
        }
        self.stops = busStops
    }
    
    enum SerializationError: Error {
        case missing(String)
        case invalid(String, Any)
    }


}

