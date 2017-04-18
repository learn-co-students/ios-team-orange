//
//  PlayerTableViewCell.swift
//  TeamOrange
//
//  Created by William Brancato on 4/18/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

import Foundation
import UIKit

class PlayerTableViewCell: UITableViewCell {
    
    let myImageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
    let usernameLabel = UILabel()
    let hometownLabel = UILabel()
    let genderLabel = UILabel()
    
    var player: Player? {
        didSet {
            guard let player = self.player else { return }
            self.usernameLabel.text = player.name
            self.hometownLabel.text = player.homeTown
            self.genderLabel.text = player.gender?.rawValue
        }
    }
    
    func buildCell() {
        self.buildImageView()
        self.buildUsernameLabel()
        self.buildHometownLabel()
        self.buildGenderLabel()
    }
    
    func buildImageView() {
        self.addSubview(self.myImageView)
        self.myImageView.translatesAutoresizingMaskIntoConstraints = false
        self.myImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.myImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.myImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        self.myImageView.widthAnchor.constraint(equalTo: self.myImageView.heightAnchor).isActive = true
    }
    
    func buildUsernameLabel() {
        self.addSubview(self.usernameLabel)
        self.usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.usernameLabel.leadingAnchor.constraint(equalTo: self.myImageView.trailingAnchor, constant: 5).isActive = true
        self.usernameLabel.centerYAnchor.constraint(equalTo: self.myImageView.centerYAnchor).isActive = true
        self.usernameLabel.lineBreakMode = .byWordWrapping
        self.usernameLabel.numberOfLines = 0
    }
    
    func buildHometownLabel() {
        self.addSubview(self.hometownLabel)
        self.hometownLabel.translatesAutoresizingMaskIntoConstraints = false
        self.hometownLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.hometownLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        self.hometownLabel.lineBreakMode = .byWordWrapping
        self.hometownLabel.numberOfLines = 0
        self.hometownLabel.textColor = UIColor.lightGray
        self.hometownLabel.font = self.hometownLabel.font.withSize(10)
    }
    
    func buildGenderLabel() {
        self.addSubview(self.genderLabel)
        self.genderLabel.translatesAutoresizingMaskIntoConstraints = false
        self.genderLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.genderLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        self.genderLabel.lineBreakMode = .byWordWrapping
        self.genderLabel.numberOfLines = 0
        self.genderLabel.textColor = UIColor.lightGray
        self.genderLabel.font = self.genderLabel.font.withSize(10)
    }
}
