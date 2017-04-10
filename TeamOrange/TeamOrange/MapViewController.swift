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
        self.view = mainView
        self.mainView.mapView.setUserTrackingMode(.follow, animated: true)
        MapKitClient.setMap(to: self.mainView.mapView)
        LocSearchClient.setFieldAndTable(from: mainView.searchBarView)
        self.mainView.centerMapButton.addTarget(self, action: #selector(centerMapButtonClicked), for: .touchUpInside)
        self.mainView.searchBarView.okButton.addTarget(self, action: #selector(searchBarButtonClicked), for: .touchUpInside)
        self.mainView.searchButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
        self.mainView.searchBarView.cancelButton.addTarget(self, action: #selector(toggleSearchView), for: .touchUpInside)
        LocSearchClient.setDismissal(to: toggleSearchView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Huddle"
        let sportsButton = UIBarButtonItem(title: "Sports", style: .plain, target: self, action: #selector(goToSportPicker) )
        let friendsButton = UIBarButtonItem(title: "Friends", style: .plain, target: self, action: #selector(goToSportPicker) )
        self.navigationItem.setRightBarButton(sportsButton, animated: false)
        // set the nav bar to clear
        self.navigationItem.setLeftBarButton(friendsButton, animated: false)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.buildLoginButton()
        // Do any additional setup after loading the view, typically from a nib.
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
        self.present(loginScreen, animated: false, completion: nil)
    }
    
    func goToSportPicker() {
        let sportsPicker = SportPickerController()
        sportsPicker.modalPresentationStyle = .overCurrentContext
        self.present(sportsPicker, animated: false, completion: nil)
    }
}









