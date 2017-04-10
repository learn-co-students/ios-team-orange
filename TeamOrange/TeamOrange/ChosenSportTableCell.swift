//
//  ChosenSportTableCell.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class ChosenSportTableCell: UITableViewCell {
    
    var sport: Sport? {
        didSet {
            if let imageView = self.imageView {
                imageView.image = self.sport?.image.image
                self.sportLabel.text = self.sport?.rawValue
            }
        }
    }
    
    let cancelButton = UIButton()
    let sportLabel = UILabel()
    
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = UIColor.clear
        self.buildImageView()
        self.buildSportLabel()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildImageView() {
        if let imageView = self.imageView {
            self.addSubview(imageView)
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.5).isActive = true
            imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
            imageView.widthAnchor.constraint(equalTo: imageView.heightAnchor).isActive = true
            imageView.contentMode = .scaleToFill
        }
    }
    
    func buildSportLabel() {
        self.addSubview(self.sportLabel)
        if let imageView = self.imageView {
            self.sportLabel.translatesAutoresizingMaskIntoConstraints = false
            self.sportLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 1).isActive = true
            self.sportLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -1).isActive = true
            self.sportLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
            self.sportLabel.lineBreakMode = .byWordWrapping
            self.sportLabel.numberOfLines = 0
        }
        
    }
}
