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
import FirebaseAuth

class MapViewController: UIViewController {
    
    lazy var mainView: MapSearchView = MapSearchView()
    let mikesFavFont = UIFont(name: "NunitoSans-Black", size: 20)
    let profileButton = UIButton()
//    let sportsButton = UIButton()
    let swipeView = UIView()
    var peekLocation: Location?
    
    override func loadView() {
        super.loadView()
        UIApplication.shared.statusBarStyle = .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "TeamUp"
        self.buildMainView()
        self.buildProfileButton()
//        self.buildSportsButton()
        NotificationCenter.default.addObserver(self, selector: #selector(self.scaleUp), name: Notification.Name("Stop Peeking"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.makePeekViewAtAnnotation), name: Notification.Name("PeekToLoc"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.goToPlayerView), name: Notification.Name("Player View With Player"), object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(self.fadeSportsButton), name: Notification.Name("Picker Collapsed"), object: nil)
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
        //TODO: As of now this function will never be called - however this is bad for user functionality, if time permits make it work.
        if let peekLocation = self.peekLocation {
            self.makePeekView(location: peekLocation)
        }
        self.navigationController?.navigationBar.isHidden = true
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
    
    func goToSportPicker() {
//        self.fadeSportsButton()
        let sportsPicker = SportPickerController()
        sportsPicker.modalPresentationStyle = .overCurrentContext
        self.present(sportsPicker, animated: false, completion: nil)
    }
    
//    func fadeSportsButton() {
//        UIView.animate(withDuration: 0.2, animations: {
//            self.sportsButton.alpha = self.sportsButton.alpha == 1 ? 0 : 1
//        })
//    }
    
    func goToPlayerView(notification: Notification) {
        guard let selectedPlayer = notification.object as? Player else { return }
        let playerController = PlayerController()
        playerController.player = selectedPlayer
        self.navigationController?.pushViewController(playerController, animated: true)
    }
    
    func buildProfileButton() {
        self.view.addSubview(self.profileButton)
        self.profileButton.translatesAutoresizingMaskIntoConstraints = false
        self.profileButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.profileButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        self.profileButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileButton.setTitleColor(UIColor.red, for: .normal)
        self.profileButton.setImage(#imageLiteral(resourceName: "IC_runner"), for: .normal)
        self.profileButton.addTarget(self.revealViewController(), action: #selector(SWRevealViewController.revealToggle(_:)), for: .touchUpInside)
    }
    
//    func buildSportsButton() {
//        self.view.addSubview(self.sportsButton)
//        self.sportsButton.translatesAutoresizingMaskIntoConstraints = false
//        self.sportsButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
//        self.sportsButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        self.sportsButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
//        self.sportsButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
//        self.sportsButton.setImage(#imageLiteral(resourceName: "sport-bag"), for: .normal)
//        self.sportsButton.addTarget(self, action: #selector(self.goToSportPicker), for: .touchUpInside)
//        self.sportsButton.titleLabel?.font = self.mikesFavFont
//    }
    
    func goToGamePeekViewTest() {
        self.view.layer.cornerRadius = 10
        self.view.clipsToBounds = true
        let coordinates = CLLocationCoordinate2D(latitude: 37.77971275757405, longitude: -122.4074749280276)
        let gamepeek = GamePeekController()
        let location = Location(gameID: "-Kh2Wlj0Cm7Cx3ZoM0bm", coordinate: coordinates)
        location.games.append("-Kh2Wlj154CmYfGDI4SW")
        location.games.append("-Kh2Wlj0Cm7Cx3ZoM0bp")
        location.games.append("-Kh2Wlj3US5xYAypY1Az")
        location.games.append("-Kh2Wlj3US5xYAypY1B1")
        gamepeek.location = location
        gamepeek.modalPresentationStyle = .overCurrentContext
        self.present(gamepeek, animated: false, completion: nil)
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    func scaleUp() {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}

extension MapViewController: MKMapViewDelegate{
    func makePeekViewAtAnnotation(_ notification: Notification) {
        if let location = notification.object as? Location {
            self.makePeekView(location: location)
        }
    }
    
    func makePeekView(location: Location) {
        self.view.layer.cornerRadius = 10
        self.view.clipsToBounds = true
        let gamepeek = GamePeekController()
        
        gamepeek.location = location
        gamepeek.modalPresentationStyle = .overCurrentContext
        self.present(gamepeek, animated: false, completion: nil)
        UIView.animate(withDuration: 0.25, animations: {
            self.view.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
}
