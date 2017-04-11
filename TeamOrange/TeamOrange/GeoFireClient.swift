//
//  GeoFireClient.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/11/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import Firebase

class GeoFireClient {
    class func test() {
        let geo = GeoFire(firebaseRef: FIRDatabase.database().reference().child("locations"))
        var loc: CLLocation
        for i in 0 ... 100{
            if i % 2 == 0{ loc = CLLocation(latitude: 40.7289, longitude: 73.9654)}
            else { loc = CLLocation(latitude: 40.8713, longitude: 73.9169)}
            geo?.setLocation(loc, forKey: "test\(i)")
        }
    }
    
    
}
