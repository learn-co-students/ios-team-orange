//
//  CoreLocClient.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import CoreLocation

final class CoreLocClient{
    private static let client = CoreLocClient()
    
    private var manager: CLLocationManager
    private var authStatus: CLAuthorizationStatus
    private var enabled: Bool
    weak var delegate: CLLocationManagerDelegate?
    
    var authorized: Bool {
        let always = authStatus == .authorizedAlways
        let whenInUse = authStatus == .authorizedWhenInUse
       return always || whenInUse
    }
    
    
    private init (){
        self.manager = CLLocationManager()
        self.authStatus = CLLocationManager.authorizationStatus()
        self.enabled = CLLocationManager.locationServicesEnabled()
        manager.startUpdatingLocation()
    }
    
    class func authCheckRequest() {
        if client.authorized && client.enabled {return}
        self.client.manager.requestWhenInUseAuthorization()
    }
    
    class func forwardGeocode(address: String, completion: @escaping (CLPlacemark?)->()) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemark, error in
            completion(placemark?.first)
        }
    }
    
    class func reverseGeocode(latitude: Double, longitude: Double, completion: @escaping (CLPlacemark?)->()) {
        let geocoder = CLGeocoder()
        let location = CLLocation(latitude: latitude, longitude: longitude)
        geocoder.reverseGeocodeLocation(location, completionHandler: { placemark, error in
            completion(placemark?.first)
        })
        
    }
}




