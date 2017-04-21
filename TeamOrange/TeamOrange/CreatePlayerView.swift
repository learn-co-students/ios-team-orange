//
//  CreatePlayerView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/20/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class CreatePlayerView: UIView {
    
    let nameEntry = UITextField()
    let hometownEntry = UITextField()
    let homeFieldEntry = UITextField()
    let genderPicker = UIPickerView()
    let sportScroll = SportIconScroll()
    var textFields: [UITextField] = []
    let submitButton = UIButton()
    let favSportLabel = UILabel()
    
    var selectedSport: String {
        let imgSelected = Int(self.sportScroll.contentOffset.x / self.sportScroll.frame.size.width)
        let img = self.sportScroll.sportIcons[imgSelected] as? ClickableImage
        return img!.sport.rawValue
    }
    
    var gender: String {
        return self.genderPicker.selectedRow(inComponent: 0) == 0 ? "Male" : "Female"
    }
    
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.gray
        self.textFields = [self.nameEntry, self.hometownEntry, self.homeFieldEntry]
        self.setupTextFields()
        self.buildButton()
        self.buildGenderPicker()
        self.buildFavSportLabel()
        self.buildSportScroll()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextFields() {
        self.textFields.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -25).isActive = true
            $0.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.04).isActive = true
            $0.backgroundColor = UIColor.white
            $0.layer.cornerRadius = 8
        }
        
        self.nameEntry.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        self.nameEntry.placeholder = "Enter username here"
        
        self.hometownEntry.topAnchor.constraint(equalTo: self.nameEntry.bottomAnchor, constant: 50).isActive = true
        self.hometownEntry.placeholder = "Enter hometown here"
        
        self.homeFieldEntry.topAnchor.constraint(equalTo: self.hometownEntry.bottomAnchor, constant: 50).isActive = true
        self.homeFieldEntry.placeholder = "Enter home field here"
    }
    
    
    func buildSportScroll() {
        self.addSubview(self.sportScroll)
        self.sportScroll.translatesAutoresizingMaskIntoConstraints = false
        self.sportScroll.topAnchor.constraint(equalTo: self.homeFieldEntry.bottomAnchor, constant: 75).isActive = true
        self.sportScroll.bottomAnchor.constraint(equalTo: self.genderPicker.topAnchor, constant: -50).isActive = true
        self.sportScroll.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.sportScroll.widthAnchor.constraint(equalTo: self.sportScroll.heightAnchor).isActive = true
        self.sportScroll.sportStack.subviews.forEach {
            $0.alpha = 1
            $0.isUserInteractionEnabled = false
        }
    }
    
    func buildButton() {
        self.addSubview(self.submitButton)
        self.submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.submitButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -25).isActive = true
        self.submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.submitButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/2).isActive = true
        self.submitButton.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/8).isActive = true
        self.submitButton.backgroundColor = UIColor.blue
        self.submitButton.layer.cornerRadius = 10
        self.submitButton.setTitle("Create My Profile", for: .normal)
        self.submitButton.addTarget(self, action: #selector(self.createUser), for: .touchUpInside)
    }
    
    func buildGenderPicker() {
        self.addSubview(self.genderPicker)
        self.genderPicker.translatesAutoresizingMaskIntoConstraints = false
        self.genderPicker.bottomAnchor.constraint(equalTo: self.submitButton.topAnchor, constant: -10).isActive = true
        self.genderPicker.centerXAnchor.constraint(equalTo: self.submitButton.centerXAnchor).isActive = true
        self.genderPicker.widthAnchor.constraint(equalTo: self.submitButton.widthAnchor).isActive = true
        self.genderPicker.heightAnchor.constraint(equalTo: self.submitButton.heightAnchor).isActive = true
    }
    
    func buildFavSportLabel() {
        self.addSubview(self.favSportLabel)
        self.favSportLabel.translatesAutoresizingMaskIntoConstraints = false
        self.favSportLabel.topAnchor.constraint(equalTo: self.homeFieldEntry.bottomAnchor, constant: 25).isActive = true
        self.favSportLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.favSportLabel.lineBreakMode = .byWordWrapping
        self.favSportLabel.numberOfLines = 0
        self.favSportLabel.text = "Choose a Favorite Sport"
    }
    
    func createUser() {
        var stop = false
        guard let name = self.nameEntry.text else { return }
        guard let hometown = self.hometownEntry.text else { return }
        guard let homeField = self.homeFieldEntry.text else { return }
        
        self.textFields.forEach { if $0.text == "" { $0.shake(); stop = true } }
        
        if stop { return }
        
        let userInfo: [String:String] = ["hometown": hometown,
                                         "homeField": homeField,
                                         "name": name,
                                         "favSport":self.selectedSport,
                                         "gender": self.gender]
        let notification = Notification(name: Notification.Name("Player Entered Info"), object: nil, userInfo: userInfo)
        NotificationCenter.default.post(notification)
    }
}
