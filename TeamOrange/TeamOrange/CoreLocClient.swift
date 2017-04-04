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
    static let client = CoreLocClient()
    
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
    
    func authCheckRequest(){
        if authorized && enabled {return}
        let request = CLLocationManager.requestWhenInUseAuthorization(manager)
        request()
    }
    
}




