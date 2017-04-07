//
//  ViewController.swift
//  mapSearchTableViewTest
//
//  Created by Edmund Holderbaum on 4/5/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    
    lazy var mainView: MapSearchView = MapSearchView()
    let loginButton = UIButton()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        self.mainView.mapView.delegate = self
        self.mainView.mapView.setUserTrackingMode(.follow, animated: true)
        
        self.mainView.centerMapButton.addTarget(self, action: #selector(centerMapButtonClicked), for: .touchUpInside)
        self.mainView.searchButton.addTarget(self, action: #selector(searchBarButtonClicked), for: .touchUpInside)
        self.mainView.searchBarView.cancelButton.addTarget(self, action: #selector(searchBarButtonClicked), for: .touchUpInside)
        self.mainView.searchBarView.searchBar.addTarget(self, action: #selector(searchLocationButtonClicked), for: .touchUpInside)
        mainView.searchBarView.searchBar.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Huddle"
        let sportsButton = UIBarButtonItem(title: "Sports", style: .plain, target: self, action: #selector(goToSportsPicker) )
        self.navigationItem.setRightBarButton(sportsButton, animated: false)
        // set the nav bar to clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.buildLoginButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func centerMapButtonClicked(){
        if self.mainView.mapView.userTrackingMode == .none {
            self.mainView.mapView.userTrackingMode = .follow
        }
    }
    
    func searchBarButtonClicked() {
        self.mainView.animateSearchBar()
    }
    
    func buildLoginButton() {
        self.view.addSubview(loginButton)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        self.loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        self.loginButton.backgroundColor = UIColor.red
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.goToLoginScreen), for: .touchUpInside)
    }
    
    func goToLoginScreen() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .overCurrentContext
        self.present(loginScreen, animated: true, completion: nil)

    }
    
    func goToSportsPicker() {
        //TODO: implement sports picker view
    }
}

extension MapViewController: CLLocationManagerDelegate, MKMapViewDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard self.mainView.mapView.userTrackingMode == .follow else {return}
        if let clLoc = locations.last {
            let center = clLoc.coordinate
            let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
            let region = MKCoordinateRegion.init(center: center, span: span)
            self.mainView.mapView.setRegion(region, animated: true)
        }
    }
    
    func mapViewWillStartRenderingMap(_ mapView: MKMapView) {
        //probably where we will be loading games / locations
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


extension MapViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .search
    }
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text != "" else {
            searchBarButtonClicked()
            return false
        }
        //WARNING: for right now this only seaches within the area that the map is currently showing.
        
        MapKitClient.requestMapSearch(with: text, within: mainView.mapView.region, completion: { success in
            DispatchQueue.main.async {
                if success{
                    //need to figure out stuff to do here, this is just testing purposes for right now
                    NSLog("%@", "successfully found Locations")
                } else {
                    //probably throw out an alert view or something...
                    NSLog("%@", "failed to find locations")
                }
            }
        })
        textField.text = ""
        textField.endEditing(true)
        searchBarButtonClicked()
        return true
    }
    
    func searchLocationButtonClicked(){
        _ = self.textFieldShouldReturn(self.mainView.searchBarView.searchBar)
    }
}





