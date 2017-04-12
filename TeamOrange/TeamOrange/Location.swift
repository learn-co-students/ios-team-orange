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
    let latitude: Double
    let longitude: Double
    var name: String
    var games: [Game]?
    let address: String?
    
    init?(dict: [String: Any]) {
        guard let lat = dict["latitude"] as? Double,
            let long = dict["longitude"] as? Double,
            let name = dict["name"] as? String else {return nil}
        self.address = dict["address"] as? String
        self.name = name
        self.latitude = lat
        self.longitude = long
    }
    
    init(name: String, coordinate: CLLocationCoordinate2D){
        self.name = name
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.address = nil
    }
    
    func changeName(to name: String) { self.name = name }
    
}

extension Location: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String?{
        return name
    }
    
}

extension CLPlacemark {
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
            return Location(dict: dict)
        }
        return nil
    }
}

extension CLLocation {
    func convertToLocation(name: String)->Location {
        return Location(name: name, coordinate: self.coordinate)
    }
}

extension MKMapItem {
    //for use when creating Locations
    func makeDict()->[String:Any]{
        let dict = [
            "name" : self.name ?? "unnamed location",
            "latitude" : self.placemark.coordinate.latitude,
            "longitude" : self.placemark.coordinate.longitude
            ] as [String : Any]
        print (dict)
        return dict
    }
}

