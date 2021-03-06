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
    var games: [String]
    var address: String? = nil
    
    var locationText: String {
        var gamesString: String
        let gameNum = games.count
        if gameNum == 1 { gamesString = "One game at this location." }
        else { gamesString = "\(games.count) games at this location." }
        return gamesString
    }
    
//    init?(dict: [String: Any]) {
//        guard let lat = dict["latitude"] as? Double,
//            let long = dict["longitude"] as? Double,
//             let gameID = dict ["games"]else {return nil}
//        self.address = dict["address"] as? String
//        self.name = dict["name"] as? String ?? nil
//        self.latitude = lat
//        self.longitude = long
//    }
    
    init(gameID: String, coordinate: CLLocationCoordinate2D){
        // TODO: Games should be grabbed from firebase and not made here.
        games = [gameID]
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
    }
    
    func addGame(id: String) {
        games.append(id)
    }
    
    func removeGame(id: String) {
        let index = games.index(of: id)
        if let index = index{ games.remove(at: index) }
    }
    
    func lookUpAddress(completion: (Bool)->()) {
        CoreLocClient.reverseGeocode(latitude: self.latitude, longitude: self.longitude, completion: { placemark in
            DispatchQueue.main.async {
                if let placemark = placemark{
                    if let street = placemark.addressDictionary?["Street"] as! String?,
                        let zip = placemark.addressDictionary?["ZIP"] as! String?{
                        self.address = "\(street), \(zip)"
                    }
                }
            }
        })
    }
    
    func isNearbyTo(_ coord: CLLocationCoordinate2D)->Bool {
        let latDiff = abs(coord.latitude - self.latitude)
        let longDiff = abs(coord.longitude - self.longitude)
        print ("latD: \(latDiff), longD: \(longDiff)~~~~~~")
        let distCheck = latDiff < 0.0002 && longDiff < 0.0002
        return distCheck
    }
}

extension Location: MKAnnotation{
    public var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String? {
        return locationText
    }
    
    var allGameIDs: String {
        return games.joined(separator: ", ")
    }//for debugging.
    
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

extension CLLocationCoordinate2D: Equatable{
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D)-> Bool{
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}

