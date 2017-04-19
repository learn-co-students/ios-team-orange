//
//  ViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class CreateGameController: UIViewController {
    lazy var mainView: CreateGameView = CreateGameView()
    var usingCurrentLoc = false
    
    var coord: CLLocationCoordinate2D {
        return mainView.mapView.userLocation.coordinate
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.buildStaticNavBar()
        self.title = "Create Game"
        self.addAndConstrain(view: self.mainView)
        mainView.addSubview(mainView.mapView)
        mainView.mapView.translatesAutoresizingMaskIntoConstraints = false
        mainView.mapView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        mainView.mapView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        mainView.mapView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        mainView.mapView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3).isActive = true
        mainView.setupSubviews()
        mainView.createButton.addTarget(self, action: #selector(printSelectedSport), for: .touchUpInside)
        mainView.useLocationButton.addTarget(self, action: #selector(populateCurrentLocation), for: .touchUpInside)
        print ("CGC viewDidLoad")
        mainView.addressField.delegate = self
        mainView.nameField.delegate = self
        mainView.mapView.setUserTrackingMode(.follow, animated: false)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func printSelectedSport(){
        print(mainView.selectedSport ?? "nil")
    }
    
    func populateCurrentLocation(){
        CoreLocClient.reverseGeocode(latitude: coord.latitude, longitude: coord.longitude, completion: { data in
            var addr = ""
            if let street = data?.addressDictionary?["Street"] as? String , let zip = data?.addressDictionary?["ZIP"] as? String{
                addr = street + " " + zip
                self.usingCurrentLoc = true
            }else{ addr = "Error getting address!" }
            DispatchQueue.main.async {
                self.mainView.addressField.text = addr
            }
        })
    }
    
    func perpareToSubmit() {
        if checkTextField(mainView.addressField)
            && checkTextField(mainView.nameField){
            if usingCurrentLoc{
                let coord = mainView.mapView.userLocation
            }
        }
    }
    
    func packageGameInfo(coord: CLLocationCoordinate2D) {
        let name = mainView.nameField.text!
        let address = mainView.addressField.text!
        let sport = mainView.selectedSport!.rawValue
        let date = mainView.datePicker.date.description
        let dict = ["name": name, "address": address, "sport": sport, "state": "Not Started"]
        InsertToFirebase.newGame(with: dict, completion: {id in
            let location = Location(gameID: id, coordinate: coord)
            
        })
    }
    
    func checkTextField(_ textField: UITextField)-> Bool {
        guard let text = textField.text else {
            animateInvalidTextField(textField)
            return false
        }
        if text.characters.count < 7 {
            animateInvalidTextField(textField)
            textField.placeholder = "Please enter a valid \(textField.accessibilityLabel!)."
            return true
        }
        return true
    }
    
    func animateInvalidTextField (_ field: UITextField) {
        UIView.animate(withDuration: 0.2, animations: {
            field.backgroundColor = UIColor.red
        }, completion: { _ in
            UIView.animate(withDuration: 0.2, animations: {
                field.backgroundColor = UIColor.white
            })
        })
    }
}


extension CreateGameController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        _ = checkTextField(textField)
        if mainView.addressField.text != nil && mainView.nameField.text != nil{
            mainView.createButton.isEnabled = true
        }
    }
    
}
