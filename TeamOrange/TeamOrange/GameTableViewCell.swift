//
//  GameTableViewCell.swift
//  TeamOrange
//
//  Created by William Brancato on 4/18/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GameTableViewCell: UITableViewCell {
    
    let nameLabel = UILabel()
    let dateLabel = UILabel()
    let numPlayersLabel = UILabel()
    
    var game: Game? {
        didSet {
            guard let game = self.game else { return }
            self.buildCell()
            game.fillArrays {
                self.nameLabel.text = game.name
                self.dateLabel.text = game.date
                self.numPlayersLabel.text = "# Playeres: \(game.numPlayers)"
            }
        }
    }
    
    func buildCell() {
        self.buildNameLabel()
        self.buildDateLabel()
        self.buildNumPlayersLabel()
    }
    
    
    func buildNameLabel() {
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        self.nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.nameLabel.lineBreakMode = .byWordWrapping
        self.nameLabel.numberOfLines = 0
    }
    
    func buildDateLabel() {
        self.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        self.dateLabel.lineBreakMode = .byWordWrapping
        self.dateLabel.numberOfLines = 0
        self.dateLabel.textColor = UIColor.lightGray
        self.dateLabel.font = self.dateLabel.font.withSize(10)
    }
    
    func buildNumPlayersLabel() {
        self.addSubview(self.numPlayersLabel)
        self.numPlayersLabel.translatesAutoresizingMaskIntoConstraints = false
        self.numPlayersLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        self.numPlayersLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
        self.numPlayersLabel.lineBreakMode = .byWordWrapping
        self.numPlayersLabel.numberOfLines = 0
        self.numPlayersLabel.textColor = UIColor.lightGray
        self.numPlayersLabel.font = self.numPlayersLabel.font.withSize(10)
    }
}

