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
        //mapView.mapType = .hybrid
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
        let identifier = "Location"
        //this will display a standard apple annotation.
        //add a custom annotation view here later.
        
        var annotationView: MKPinAnnotationView
        if let rawAnnotationView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            annotationView = rawAnnotationView
            annotationView.annotation = annotation
        } else {
            //this part adds an annotation view if one hasnt been dequeued for this location
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView.canShowCallout = true
            let btn = UIButton(type: .detailDisclosure)
            //this button will call calloutAccessoryTapped
            annotationView.rightCalloutAccessoryView = btn
            //if let _ = annotation as? Location { annotationView.pinTintColor = UIColor.cyan }
            //else { annotationView.pinTintColor = UIColor.purple }
            switch annotation{
                // conclusion: this function is currently dequeueing the wrong annotationView after repeated location searches.
                // TODO: investigate the source of this bug. 
            case is MKPlacemark, is MKUserLocation:
                break
            case is Location :
                annotationView.pinTintColor = UIColor.cyan
                break
            default:
                annotationView.pinTintColor = UIColor.green
            }
        }
        return annotationView
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        guard let location = view.annotation as? Location else { return }
        
        //this part gets some basic data from the location.
        
        //present an alert controller with the name and message from above
        //replace this with a different action once UI is built
        let ac = UIAlertController(title: "gameLocation", message: location.name, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        GeoFireClient.queryLocations(within: mapView.region, response: { response in
            DispatchQueue.main.async {
                
                for annotation in mapView.annotations{
                    guard let location = annotation as? Location else {continue}
                    //print("ck: \(location.coordinate), \(response.1.coordinate)")
                    if location.coordinate == response.1.coordinate{
                        location.addGame(id: response.0)
                        return
                    }
                }
                mapView.addAnnotation( Location(gameID: response.0, coordinate: response.1.coordinate) )
            }
        })
    }
    
}



