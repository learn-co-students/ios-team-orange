//
//  CreateGameView.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit
import MapKit

class CreateGameView: UIView {

    lazy var locToggler = UISegmentedControl()
    lazy var mapView = MKMapView()
    lazy var createButton = UIButton()
    lazy var nameField = UITextField()
    lazy var addressField = UITextField()
    lazy var datePicker = UIDatePicker()
    lazy var sportPicker = SportIconScroll()
    lazy var useLocationButton = UIButton()
    lazy var maxPlayers = UIPickerView()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupSubviews(){
        print("CGV Setup")
        self.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07, constant: 0).isActive = true
        createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: createButton.frame.height/2).isActive = true
        createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createButton.layer.cornerRadius = 8
        createButton.setTitle("Create Game", for: .normal)
        createButton.setTitle("Create Game", for: .disabled)
        createButton.backgroundColor = UIColor.white
        createButton.setTitleColor(createButton.tintColor, for: .normal)
        createButton.setTitleColor(UIColor.gray, for: .disabled)
        createButton.isEnabled = false
        
        addAndConstrainTextField( nameField, to: mapView)
        nameField.accessibilityLabel = "Game Name"
        nameField.placeholder = "Game Name (at least 7 letters)"
        
        addAndConstrainTextField(addressField, to: nameField)
        addressField.placeholder = "Address"
        addressField.accessibilityLabel = "Address"
        
        let dateContainer = makePickerContainer(constrainedTo: addressField)
        addSubview(datePicker)
        datePicker.addAndConstrainToEdges(of: dateContainer)
        datePicker.tintColor = UIColor.white
        datePicker.minimumDate = Date(timeIntervalSinceNow: 0)
        
        let sportContainer = makePickerContainer(constrainedTo: dateContainer)
        addSubview(sportPicker)
        sportPicker.addAndConstrainToEdges(of: sportContainer)
        sportPicker.sportIcons.forEach({
            $0.isUserInteractionEnabled = false
            $0.alpha = 1
        })
        
        self.addSubview(useLocationButton)
        useLocationButton.translatesAutoresizingMaskIntoConstraints = false
        useLocationButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        useLocationButton.heightAnchor.constraint(equalToConstant: 16).isActive = true
        useLocationButton.widthAnchor.constraint(equalTo: addressField.widthAnchor, multiplier: 0.4).isActive = true
        useLocationButton.topAnchor.constraint(equalTo: addressField.bottomAnchor).isActive = true
        useLocationButton.setTitle("Current Location", for: .normal)
        useLocationButton.titleLabel?.adjustsFontSizeToFitWidth = true
        useLocationButton.setTitleColor(useLocationButton.tintColor, for: .normal)
        
        let maxPlayersContainer = makePickerContainer(constrainedTo: sportPicker)
        self.addSubview(maxPlayers)
        maxPlayers.addAndConstrainToEdges(of: maxPlayersContainer)
        
        let label = UILabel()
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.bottomAnchor.constraint(equalTo: maxPlayersContainer.topAnchor).isActive = true
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        label.centerXAnchor.constraint(equalTo: maxPlayersContainer.centerXAnchor).isActive = true
        label.text = "Maximum number of Players:"
    }
    
    func addAndConstrainTextField(_ field: UITextField, to view: UIView){
        self.addSubview(field)
        field.translatesAutoresizingMaskIntoConstraints = false
        field.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        field.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.04, constant: 0).isActive = true
        field.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 32).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        field.layer.cornerRadius = 8
        field.backgroundColor = UIColor.white
        field.textColor = UIColor.darkGray
        field.returnKeyType = .done
    }
    
    func makePickerContainer(constrainedTo view: UIView)->UIView{
        let container = UIView()
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.12, constant: 0).isActive = true
        container.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 32).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        return container
    }
    
    var selectedSport: Sport? {
        let imgSelected = Int(sportPicker.contentOffset.x / sportPicker.frame.size.width)
        let img = sportPicker.sportIcons[imgSelected] as? ClickableImage
        return img?.sport
    }
}
