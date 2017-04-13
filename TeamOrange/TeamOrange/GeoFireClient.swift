//
//  GeoFireClient.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/11/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Firebase
import MapKit

final class GeoFireClient {
    static let geo = GeoFire(firebaseRef: FIRDatabase.database().reference().child("locations"))
    //private static var
    class func addLocation(game id: String, coordinate: CLLocationCoordinate2D) {
        let loc  = CLLocation(latitude: coordinate.latitude, longitude: coordinate.longitude)
        geo?.setLocation(loc, forKey: id, withCompletionBlock:{ error in
            NSLog("%@", "added location at (\(coordinate.latitude), \(coordinate.longitude) ")
            if let error = error{ print (error.localizedDescription) }
        })
        
    }
    
    class func queryLocations(within region: MKCoordinateRegion, response: @escaping (String, CLLocation)->()){
        //remove locations from map first!
        
        let query = geo?.query(with: region)
        query?.observe(.keyEntered, with: { key, location in
            //key is game id
            //location is CLLocation
            guard let location = location
                , let key = key else { return }
            response(key, location)
        })
    }
    
}
