//
//  PlayerView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: UIView {
    
    var imageView: UIImageView!
    var nameLabel = UILabel()
    let tableView = UITableView()
    var friendButton = UIButton()
    let mikesFavFont = UIFont(name: "NunitoSans-Black", size: 20)
    
    weak var playerDelegate: (PlayerViewDelegate & UITableViewDelegate & UITableViewDataSource)?
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        print(self.playerDelegate?.player.propertyDictionary)
        self.buildImageView()
        self.buildTableView()
    }
    
    func buildImageView() {
        self.imageView = UIImageView(image: #imageLiteral(resourceName: "runner-noBackground"))
        self.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.imageView.alpha = 0.75
    }
    
    func buildTableView() {
        self.addSubview(self.tableView)
        self.tableView.translatesAutoresizingMaskIntoConstraints = false
        self.tableView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        self.tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.tableView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.tableView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    func buildFriendButton() {
        friendButton = AddFriendButton()
        addSubview(friendButton)
        friendButton.translatesAutoresizingMaskIntoConstraints = false
        friendButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        friendButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        friendButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.15).isActive = true
        friendButton.heightAnchor.constraint(equalTo: friendButton.widthAnchor).isActive = true
        
        let label = UILabel()
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.topAnchor.constraint(equalTo: friendButton.bottomAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: friendButton.centerXAnchor, constant: 1).isActive = true
        label.text = "Friend"
    }
    
    func buildNameLabel() {
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        self.nameLabel.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -50).isActive = true
        self.nameLabel.lineBreakMode = .byWordWrapping
        self.nameLabel.numberOfLines = 0
        self.nameLabel.text = self.playerDelegate?.player.name
        self.nameLabel.font = self.mikesFavFont
        self.nameLabel.textColor = UIColor.red
    }
}
