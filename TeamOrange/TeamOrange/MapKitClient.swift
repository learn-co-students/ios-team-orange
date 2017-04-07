//
//  MapKitClient.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/6/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

final class MapKitClient {
    
    weak var mapView: MKMapView?
    private static var client = MapKitClient()
    
    private init(){}
    
    class func requestMapSearch (with text: String, within region: MKCoordinateRegion, completion: @escaping (Bool)->()) {
        guard let mapView = client.mapView else {return}
        let searchRequest = MKLocalSearchRequest()
        //set search request and region for search to those received from origin
        //we may be able to set region by converting from search radius miles to lat & long coordinate
        searchRequest.naturalLanguageQuery = text
        searchRequest.region = region
        let searchProcess = MKLocalSearch(request: searchRequest)
        searchProcess.start(completionHandler: {response, error in
            if let response = response {
                //unwrap the response
                NSLog("%@", "got response, locations found")
                response.mapItems.forEach({ mapItem in
                    //loop over each map item in the response
                    NSLog("%@", mapItem.name ?? "No location/name",mapItem.placemark.coordinate.latitude, ",", mapItem.placemark.coordinate.longitude)
                    if let location = Location(id: "nil", dict: mapItem.makeDict()){
                        NSLog("%@", "location made ",location.name, "-", location.latitude ?? "err", ",", location.longitude ?? "err")
                        //mapView.addAnnotation(location)
                    }//map items are converted to our Location type and added in to the map directly
                })
                NSLog("%@","calling completion")
                //then call completion with true 
                completion(true)
            } else if response == nil {
                NSLog("%@","got response, no locations found")
                completion(false)
                //i have added a false completion so user can be notified that their search turned up nothing
            }
            else {
                NSLog("%@", "no response")
                completion(false)
            }
        })
    }
    
    class func setMap(to mapView: MKMapView){
        client.mapView = mapView
    }
    
}

extension MKMapItem{
    func makeDict()->[String:Any]{
        let dict = [
            "name" : self.name ?? "unnamed location" ,
            "address" : "none given",
            "latitude" : self.placemark.coordinate.latitude,
            "longitude" : self.placemark.coordinate.longitude
        ] as [String : Any]
        print (dict)
        return dict
    }
}
