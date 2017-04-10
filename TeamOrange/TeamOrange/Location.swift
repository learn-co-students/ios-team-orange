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

extension CLPlacemark{
    func convertToLocation()-> Location? {
        if let street = self.addressDictionary?["Street"],
        let zip = self.addressDictionary?["ZIP"],
        let name = self.name,
        let latitude = self.location?.coordinate.latitude,
        let longitude = self.location?.coordinate.longitude {
            let address = "\(street), \(zip)"
            let dict: [String: Any] = [
                "name": name,
                "address" : address,
                "latitude" : latitude,
                "longitude" : longitude
            ]
            return Location(id: "none", dict: dict)
        }
        return nil
    }
}

