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
import FirebaseDatabase

class MapViewController: UIViewController {
    
    
    lazy var mainView: MapSearchView = MapSearchView()
    let mikesFavFont = UIFont(name: "SFSportsNight", size: 20)
    let profileButton = UIButton()
    let sportsButton = UIButton()
    
    override func loadView() {
        super.loadView()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.makeCreateLocationButton()
        self.buildMainView()
        self.setNavBarToClear()
        self.buildProfileButton()
        self.buildSportsButton()
//        self.navigationController?.setNavBarTitle()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MapKitClient.setMap(to: self.mainView.mapView)
        LocSearchClient.setFieldAndTable(from: mainView.searchBarView)
        LocSearchClient.setDismissal(to: toggleSearchView)
        
        //TODO: these buttons need to be pharmed out to the correct locations as the below four functions should not live on the controller
        self.mainView.centerMapButton.addTarget(self, action: #selector(centerMapButtonClicked), for: .touchUpInside)
        self.mainView.searchBarView.okButton.addTarget(self, action: #selector(searchBarButtonClicked), for: .touchUpInside)
        self.mainView.searchButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
        self.mainView.searchBarView.cancelButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func centerMapButtonClicked(){
        if self.mainView.mapView.userTrackingMode == .none {
            self.mainView.mapView.userTrackingMode = .follow
        }
    }
    
    func searchBarButtonClicked() {
        LocSearchClient.searchReady()
    }
    
    func toggleSearchView(){
        self.mainView.animateSearchBar()
    }
    
    func buildMainView() {
        self.view.addSubview(self.mainView)
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        self.mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mainView.mapView.setUserTrackingMode(.follow, animated: true)
    }
    
    func setNavBarToClear() {
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }
    
    func goToLoginScreen() {
        let loginScreen = LoginViewController()
        self.navigationController?.pushViewController(loginScreen, animated: false)
//        loginScreen.modalPresentationStyle = .overCurrentContext
//        self.present(loginScreen, animated: false, completion: nil)
    }
    
    func goToSportPicker() {
        let sportsPicker = SportPickerController()
        
        sportsPicker.modalPresentationStyle = .overCurrentContext
        self.present(sportsPicker, animated: false, completion: nil)
    }
    
    func buildProfileButton() {
        self.view.addSubview(self.profileButton)
        self.profileButton.translatesAutoresizingMaskIntoConstraints = false
        self.profileButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.profileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.profileButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.profileButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.profileButton.setTitle("Profile", for: .normal)
        self.profileButton.setTitleColor(UIColor.red, for: .normal)
        self.profileButton.addTarget(self, action: #selector(self.goToLoginScreen), for: .touchUpInside)
        self.profileButton.titleLabel?.font = self.mikesFavFont
    }
    
    func buildSportsButton() {
        self.view.addSubview(self.sportsButton)
        self.sportsButton.translatesAutoresizingMaskIntoConstraints = false
        self.sportsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.sportsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.sportsButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        self.sportsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.sportsButton.setTitle("Sports", for: .normal)
        self.sportsButton.setTitleColor(UIColor.red, for: .normal)
        self.sportsButton.addTarget(self, action: #selector(self.goToSportPicker), for: .touchUpInside)
        self.sportsButton.titleLabel?.font = self.mikesFavFont
    }
    
    
    func goToGamePeakView() {
        self.view.layer.cornerRadius = 10
        self.view.clipsToBounds = true
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
}

// MARK: temporary create location entry at map center button
extension MapViewController {
    func makeCreateLocationButton () {
        let button = UIButton()
        self.mainView.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.heightAnchor.constraint(equalToConstant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 20).isActive = true
        button.bottomAnchor.constraint(equalTo: self.mainView.bottomAnchor).isActive = true
        button.leadingAnchor.constraint(equalTo: self.mainView.leadingAnchor).isActive = true
        button.addTarget(self, action: #selector(makeLocationAtCenter), for: .touchUpInside)
        button.backgroundColor = UIColor.cyan
    }
    
    
    
    func makeLocationAtCenter () {
        let id = arc4random()
        GeoFireClient.addLocation(game: "testGame-\(id)", coordinate: self.mainView.mapView.centerCoordinate)
    }
}







