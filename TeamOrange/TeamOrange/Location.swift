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
    var games: [Game]
    var address: String?
    
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
        ////THIS FUNCTION WILL NEED TO BE CHANGED
        let firstGame = Game(id: gameID, dict: [:])
        ////GAMES MUST BE GRABBED FROM FIREBASE NOT CREATED HERE
        games = [firstGame]
        self.latitude = coordinate.latitude
        self.longitude = coordinate.longitude
        self.address = nil
    }
    
    func addGame(id: String) {
        let newGame = Game(id: id, dict: [:])
        self.games.append(newGame)
    }
    func lookUpAddress(){
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
    
}

extension Location: MKAnnotation{
    public var coordinate: CLLocationCoordinate2D{
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    public var title: String?{
        return locationText
    }
    
    var allGameIDs: String{
        let ids = games.map({$0.id})
        let desc = ids.joined(separator: ", ")
        return desc
    }//for debugging.
    
}

//extension CLPlacemark {
//    func convertToLocation()-> Location? {
//        if let street = self.addressDictionary?["Street"],
//        let zip = self.addressDictionary?["ZIP"],
//        let name = self.name,
//        let latitude = self.location?.coordinate.latitude,
//        let longitude = self.location?.coordinate.longitude {
//            let address = "\(street), \(zip)"
//            let dict: [String: Any] = [
//                "name": name,
//                "address" : address,
//                "latitude" : latitude,
//                "longitude" : longitude
//            ]
//            return Location(dict: dict)
//        }
//        return nil
//    }
//}

//extension CLLocation {
//    func convertToLocation(name: String)->Location {
//        return Location(name: name, coordinate: self.coordinate)
//    }
//}

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
