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
    let loginButton = UIButton()
    
    override func loadView() {
        super.loadView()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let font = UIFont(name: "SFSportsNight", size: 20)
        self.navigationItem.title = ""
//        let friendsButton = UIBarButtonItem(title: "Profile", style: .plain, target: self, action: #selector(goToSportPicker) )
//        friendsButton.setTitleTextAttributes([NSFontAttributeName : font], for: .normal)

//        self.navigationItem.setLeftBarButton(friendsButton, animated: false)

        
//        set the nav bar to clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear

        self.makeCreateLocationButton()

        self.view.addSubview(self.mainView)
        self.mainView.translatesAutoresizingMaskIntoConstraints = false
        self.mainView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: UIApplication.shared.statusBarFrame.height).isActive = true
        self.mainView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.mainView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.mainView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.mainView.mapView.setUserTrackingMode(.follow, animated: true)
        
        self.buildLoginButton()
        
        self.navigationController?.isNavigationBarHidden = false
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        MapKitClient.setMap(to: self.mainView.mapView)
        LocSearchClient.setFieldAndTable(from: mainView.searchBarView)
        self.mainView.centerMapButton.addTarget(self, action: #selector(centerMapButtonClicked), for: .touchUpInside)
        self.mainView.searchBarView.okButton.addTarget(self, action: #selector(searchBarButtonClicked), for: .touchUpInside)
        self.mainView.searchButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
        self.mainView.searchBarView.cancelButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
        LocSearchClient.setDismissal(to: toggleSearchView)
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
    
    func buildLoginButton() {
        self.view.addSubview(self.loginButton)
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
        self.navigationController?.pushViewController(loginScreen, animated: false)
//        loginScreen.modalPresentationStyle = .overCurrentContext
//        self.present(loginScreen, animated: false, completion: nil)
    }
    
    func goToSportPicker() {
        let sportsPicker = SportPickerController()
        
        sportsPicker.modalPresentationStyle = .overCurrentContext
        self.present(sportsPicker, animated: false, completion: nil)
    }
    
    
    
    func goToGamePeekView() {
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
        self.mainView.mapView.annotations.forEach({ locaiton in
            guard let loc = locaiton as? Location else {return}
            print (loc.address)
        })
    }
}







