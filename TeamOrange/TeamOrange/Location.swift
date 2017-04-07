//
//  Location.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//


import Foundation
import MapKit

class Location: NSObject {
    let id: String
    let latitude: Double?
    let longitude: Double?
    let name: String
    var games: [Game]?
    let address: String
    var users:[Player]?
    
    init?(id: String, dict: [String: Any]) {
        self.id = id
        guard let addr = dict["address"] as? String,
            let name = dict["name"] as? String else {return nil}
        self.address = addr
        self.name = name
        self.latitude = dict["latitude"] as? Double
        self.longitude = dict["longitude"] as? Double
    }
}

extension Location: MKAnnotation{
    public var coordinate: CLLocationCoordinate2D{
        guard let lat = latitude, let long = longitude else{
            NSLog("%@", "(Location): Error creating annotation, latitude and longitude empty")
            return CLLocationCoordinate2D(latitude: 180, longitude: 180)
        }
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    public var title: String?{
        return name
    }
    
}

