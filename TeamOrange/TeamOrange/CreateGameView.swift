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
    lazy var datePicker = UIPickerView()
    lazy var sportPicker = SportIconScroll()
    var fieldLabels = [UILabel]()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.backgroundColor = UIColor.gray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    func setupSubviews(){
        print("CGV Setup")
        self.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07, constant: 0).isActive = true
        createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: createButton.frame.height/2).isActive = true
        createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createButton.layer.cornerRadius = 0.6
        createButton.setTitle("Invite Players", for: .normal)
        createButton.backgroundColor = UIColor.white
        createButton.titleLabel?.textColor = UIColor.gray
        
        addAndConstrainTextField( nameField, to: mapView)
        nameField.accessibilityLabel = "Name"
        let nameLabel = UILabel()
        addAndConstrainLabel(nameLabel, to: nameField)
        
        addAndConstrainTextField(addressField, to: nameField)
        addressField.accessibilityLabel = "Address"
        let addressLabel = UILabel()
        addAndConstrainLabel(addressLabel, to: addressField)
        
        
        let dateContainer = makePickerContainer(constrainedTo: addressField)
        dateContainer.accessibilityLabel = "Date"
        addSubview(datePicker)
        datePicker.addAndConstrainToEdges(of: dateContainer)
        let dateLabel = UILabel()
        addAndConstrainLabel(dateLabel, to: dateContainer)
        
        let sportContainer = makePickerContainer(constrainedTo: dateContainer)
        sportContainer.accessibilityLabel = "Sport"
        addSubview(sportPicker)
        sportPicker.addAndConstrainToEdges(of: sportContainer)
        sportPicker.sportIcons.forEach({
            $0.isUserInteractionEnabled = false
            $0.alpha = 1
        })
        let sportLabel = UILabel()
        addAndConstrainLabel(sportLabel, to: sportContainer)
    }
    
    func addAndConstrainLabel(_ label: UILabel, to view: UIView){
        self.addSubview(label)
        fieldLabels.append(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalToConstant: 16).isActive = true
        label.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        //label.roundCorners(corners: [.topLeft, .topRight], radius: 6)
        //label.isOpaque = true
        label.backgroundColor = UIColor.gray
        label.textColor = UIColor.white
        if let accLabel = view.accessibilityLabel{
            label.text = accLabel
            label.accessibilityLabel = accLabel + " Label"
        }
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
    }
    
    func makePickerContainer(constrainedTo view: UIView)->UIView{
        let container = UIView()
        self.addSubview(container)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        container.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.15, constant: 0).isActive = true
        container.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 32).isActive = true
        container.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        return container
    }
    
    var selectedSport: Sport? {
        let imgSelected = Int(sportPicker.sportStack.bounds. / sportPicker.frame.size.width)
        let img = sportPicker.sportIcons[imgSelected] as? ClickableImage
        return img?.sport
    }
}
