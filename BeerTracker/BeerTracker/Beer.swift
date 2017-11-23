//
//  Beer.swift
//  BeerTracker
//
//  Created by Jane Appleseed on 11/10/16.
//  Copyright © 2016 Apple Inc. All rights reserved.
//

import UIKit

class Beer {
    
    //MARK: Properties
    
    var name: String
    var city: String
    var state: String
    var code: Int
    var country: String
    var phone: String
    var website: String
    var type: String
    var updated: Date
    var description: String
    var street: String
    var accuracy: String
    var lat: String
    var long: String
    
    //MARK: Initialization
    
    init?(name: String, city: String, state: String, code: Int,
          country: String, phone: String, website: String,
          type: String, updated: String, description: String,
          street: String, accuracy: String, lat: String, long: String ) {
        
        
        // Initialize stored properties.
        self.name = name
        self.city = city
        self.state = state
        self.code = code
        self.country = country
        self.phone = phone
        self.website = website
        self.type = type
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss.A"
        self.updated = dateFormatter.date(from: updated)!
        self.description = description
        self.street = street
        self.accuracy = accuracy
        self.lat = lat
        self.long = long
        
    }
}
