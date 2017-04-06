//
//  MapKitClient.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

final class MapKitClient: NSObject{
    
    weak var mapView: MKMapView?
    private var client = MapKitClient()
    
    private override init(){}
    
}



extension FirebaseClient {
    
    class func getLocationsFor(fromLatitude: Double, toLatitude: Double, fromLongitude: Double, toLonglogitude: Double) -> [Location]{
        //this function should get ALL data for the location so that it can be displayed to the user in info views
        return [Location]()
    }
    
}




