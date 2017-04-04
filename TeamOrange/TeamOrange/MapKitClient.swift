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

class MapKitClient{
    
}

protocol MapUpdater: CLLocationManagerDelegate, MKMapViewDelegate {
    weak var mapView: MKMapView! {get set}
    
}

extension MapUpdater{
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let clLoc = locations.last {
            let center = clLoc.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion.init(center: center, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "Location"
        if annotation is Location{ // will only fire off for a Location
            //this will display a standard apple annotation.
            //add a custom annotation view here later.
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as! MKPinAnnotationView
            if annotationView.annotation == nil{
                //this part adds an annotation view if one hasnt been dequeued for this location
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                //this button will call calloutAccessoryTapped
                annotationView.rightCalloutAccessoryView = btn
            }else{
                //if view for this location has been dequeued, show the annotation
                annotationView.annotation = annotation
            }
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? Location else { return }
        
        //this part gets some basic data from the location. 
        let locationName = location.name
        var gamesString = "No game data for this location"
        if let games = location.games?.count {
            if games == 1 { gamesString = "One game at this location." }
            else { gamesString = "\(games) games at this location." }
        }//fallthrough to default gamesString if location.games == nil
        
        //present an alert controller with the name and message from above
        //replace this with a different action once UI is built
        let ac = UIAlertController(title: locationName, message: gamesString, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
    }
}

extension FirebaseClient {
    
    class func getLocationsFor(fromLatitude: Double, toLatitude: Double, fromLongitude: Double, toLonglogitude: Double) -> [Location]{
        //this function should get ALL data for the location so that it can be displayed to the user in info views
        return [Location]()
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
}

