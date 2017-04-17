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

final class MapKitClient: NSObject {
    
    lazy var mapView = MKMapView()
    fileprivate static var client = MapKitClient()
    
    
    private override init(){
        super.init()
    }
    
    class func goTo(place: CLPlacemark) {
        let annotation = MKPlacemark(placemark: place)
        client.mapView.removeAnnotations(client.mapView.annotations)
        client.mapView.addAnnotation(annotation)
        client.mapView.setCenter(annotation.coordinate, animated: true)
    }
}

extension MapKitClient: CLLocationManagerDelegate, MKMapViewDelegate {
    class func setMap(to mapView: MKMapView) {
        client.mapView = mapView
        mapView.delegate = client
        mapView.isRotateEnabled = false
        mapView.showsPointsOfInterest = false
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard mapView.userTrackingMode == .follow else {return}
        if let clLoc = locations.last {
            let center = clLoc.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion.init(center: center, span: span)
            mapView.setRegion(region, animated: true)
        }
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        //this will display a standard apple annotation.
        //add a custom annotation view here later.
        if annotation is Location{
            let identifier = "Location"
            var annotationView: MKPinAnnotationView
            if let rawAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                annotationView = rawAnnotationView
                annotationView.annotation = annotation
            } else {
                //this part adds an annotation view if one hasnt been dequeued for this location
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
            }
            annotationView.pinTintColor = UIColor.cyan
            return annotationView
        }
        
        if annotation is MKPlacemark{
            let identifier = "Placemark"
            var annotationView: MKPinAnnotationView
            if let rawAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
                annotationView = rawAnnotationView
                annotationView.annotation = annotation
            } else {
                //this part adds an annotation view if one hasnt been dequeued for this location
                annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
                annotationView.canShowCallout = true
                let btn = UIButton(type: .detailDisclosure)
                annotationView.rightCalloutAccessoryView = btn
            }
            annotationView.pinTintColor = UIColor.red
            return annotationView
        }
        return nil
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if view.annotation is Location {
            let loc = view.annotation as! Location
            print (loc.allGameIDs)
            let message = Notification(name: Notification.Name("PeakToLoc"), object: loc, userInfo: nil)
            NotificationCenter.default.post(message)
        }
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {

        GeoFireClient.queryLocations(within: mapView.region, response: { response in
            let coord = response.1.coordinate
            let id = response.0
            QueryFirebase.forGameWith(id: id, completion: { game in
                let alreadyStarted = game.state?.rawValue != "Not Started"
                if alreadyStarted { return }
                DispatchQueue.main.async {
                    //when callback received, loop over annotations looking for one that matches the location
                    for annotation in mapView.annotations{
                        guard annotation is Location,
                            let location = annotation as? Location else {continue}
                        //conditions: the game has not started, is not over, is not nil, is not contained at that Location already, and has the same coordinates as the location in question.
                        let idCheck = !(location.games.contains(id))
                        let coordCheck = location.coordinate == coord
                        //now check those conditions, and if so add the game to the location, signal to end location search loop if so
                        if  coordCheck && idCheck {
                            location.addGame(id: response.0)
                            return
                        }// end the loop
                    }//if no location matching the game's coordinates has been found, create a new one
                    let newLocation = Location(gameID: id, coordinate: coord)
                    mapView.addAnnotation(newLocation)
                    newLocation.lookUpAddress()
                }
            })
        })
    }
}



