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
    var fieldLabels = [UILabel]()
    
    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    func setupSubviews(){
        self.addSubview(createButton)
        createButton.translatesAutoresizingMaskIntoConstraints = false
        createButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07, constant: 0).isActive = true
        createButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.3, constant: 0).isActive = true
        createButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: createButton.frame.height/2).isActive = true
        createButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        createButton.layer.cornerRadius = 0.6
        createButton.titleLabel?.text = "Create"
        createButton.backgroundColor = UIColor.gray
        createButton.titleLabel?.textColor = UIColor.white
        
        addAndConstrainTextField( nameField, to: mapView)
        nameField.accessibilityLabel = "Name"
        let nameLabel = UILabel()
        addAndConstrainLabel(nameLabel, to: nameField)
        
        addAndConstrainTextField(addressField, to: nameField)
        addressField.accessibilityLabel = "Address"
        let addressLabel = UILabel()
        addAndConstrainLabel(addressLabel, to: addressField)
        
        
    }
    
    func addAndConstrainLabel(_ label: UILabel, to view: UIView){
        self.addSubview(label)
        fieldLabels.append(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.4, constant: 0).isActive = true
        label.bottomAnchor.constraint(equalTo: view.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        label.roundCorners(corners: [.topLeft, .topRight], radius: 6)
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
        field.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7, constant: 0).isActive = true
        field.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.07, constant: 0).isActive = true
        field.topAnchor.constraint(equalTo: view.bottomAnchor, constant: view.frame.height + 10).isActive = true
        field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        field.roundCorners(corners: [.bottomLeft, .bottomRight, .topLeft], radius: 6)
        field.backgroundColor = UIColor.gray
        field.textColor = UIColor.white
    }
}
