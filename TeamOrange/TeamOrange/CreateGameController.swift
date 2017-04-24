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
    
    var coord: CLLocationCoordinate2D?
    
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
        mainView.createButton.addTarget(self, action: #selector(perpareToSubmit), for: .touchUpInside)
        mainView.useLocationButton.addTarget(self, action: #selector(populateCurrentLocation), for: .touchUpInside)
        print ("CGC viewDidLoad")
        mainView.addressField.delegate = self
        mainView.nameField.delegate = self
        mainView.mapView.setUserTrackingMode(.follow, animated: false)
        coord = mainView.mapView.userLocation.coordinate
        mainView.maxPlayers.delegate = self
        mainView.maxPlayers.dataSource = self
        self.navigationController?.navigationBar.isHidden = false
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func populateCurrentLocation(){
        coord = mainView.mapView.userLocation.coordinate
        CoreLocClient.reverseGeocode(latitude: coord!.latitude, longitude: coord!.longitude, completion: { data in
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
            && checkTextField(mainView.nameField)
            && coord != nil {
            let name = mainView.nameField.text!
            let address = mainView.addressField.text!
            let sport = mainView.selectedSport!.rawValue
            let date = mainView.datePicker.date.description
            let max = mainView.maxPlayers.selectedRow(inComponent: 0) + 2
            let dict: [String:Any] = ["name": name, "address": address, "date": date, "sport": sport, "state": "Not Started", "maxPlayers": max]
            InsertToFirebase.newGame(with: dict, completion: {id in
                let location = Location(gameID: id, coordinate: coord!)
                GeoFireClient.addLocation(game: id, coordinate: coord!, completion: {
                    //perform segue! pass in location
                })
                InsertToFirebase.player(withId: CurrentPlayer.player.id, toGame: id, completion: {
                    InsertToFirebase.admin(withId: CurrentPlayer.player.id, toGame: id)
                    print ("PLEASE PLEASE WORK")
                self.dismiss(animated: true, completion: nil)
                })
            })
        }
    }
    
    func checkTextField(_ textField: UITextField)-> Bool {
        guard let text = textField.text else {
            animateInvalidTextField(textField)
            return false
        }
        if text.characters.count < 7 {
            animateInvalidTextField(textField)
            textField.placeholder = "Please enter a valid \(textField.accessibilityLabel!)."
            return false
        }
        return true
    }
    
    func animateInvalidTextField (_ field: UITextField) {
        UIView.animate(withDuration: 0.4, animations: {
            field.backgroundColor = UIColor.red
        }, completion: { _ in
            UIView.animate(withDuration: 0.6, animations: {
                field.backgroundColor = UIColor.white
            })
        })
    }
}


extension CreateGameController: UITextFieldDelegate {
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard checkTextField(textField) else { return }
        if !usingCurrentLoc && textField.accessibilityLabel == "Address"{
            mainView.mapView.removeAnnotations(mainView.mapView.annotations)
            CoreLocClient.forwardGeocode(address: textField.text!, completion: { placemark in
                DispatchQueue.main.async {
                    if let addrCoord = placemark?.location?.coordinate{
                        self.mainView.mapView.addAnnotation(MKPlacemark(coordinate: addrCoord))
                        self.mainView.mapView.setCenter(addrCoord, animated: false)
                        self.coord = addrCoord
                    }else {
                        self.animateInvalidTextField(self.mainView.addressField)
                        self.mainView.addressField.placeholder = "Could not locate address"
                        self.mainView.addressField.text = nil
                    }
                }
            })
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        _ = textFieldShouldEndEditing(textField)
        textFieldDidEndEditing(textField)
        textField.resignFirstResponder()
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if checkTextField( mainView.addressField) && checkTextField(mainView.nameField){
            mainView.createButton.isEnabled = true
        } else { mainView.createButton.isEnabled = false }
        return true
    }
    
}

extension CreateGameController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 49
    }
    
    func pickerView(_ pickerView: UIPickerView, attributedTitleForRow row: Int, forComponent component: Int) -> NSAttributedString? {
        return NSAttributedString(string: "\(row + 2)")
    }
}
