//
//  GameView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/18/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GameView: UIView {
    
    var collectionView: UICollectionView!
    var nameLabel = UILabel()
    var sportIcon = UIImageView()
    var addressLabel = UILabel()
    var dateLabel = UILabel()
    
    weak var delegate: GameViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        self.buildView()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.buildCollectionView()
        self.buildNameLabel()
        self.buildSportIcon()
        self.buildDateLabel()
        self.buildaddressLabel()
    }
    
    func buildCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 100, height: 100)
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "playerCell")
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 5).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.collectionView.backgroundColor = UIColor.gray
    }
    
    func buildNameLabel() {
        self.addSubview(self.nameLabel)
        self.nameLabel.translatesAutoresizingMaskIntoConstraints = false
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.nameLabel.lineBreakMode = .byWordWrapping
        self.nameLabel.numberOfLines = 0
    }
    
    func buildSportIcon() {
        self.addSubview(self.sportIcon)
        self.sportIcon.translatesAutoresizingMaskIntoConstraints = false
        self.sportIcon.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor, constant: 10).isActive = true
        self.sportIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.sportIcon.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.5).isActive = true
        self.sportIcon.heightAnchor.constraint(equalTo: self.sportIcon.widthAnchor).isActive = true
        
    }
    
    func buildDateLabel() {
        self.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.topAnchor.constraint(equalTo: self.sportIcon.bottomAnchor, constant: 10).isActive = true
        self.dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.dateLabel.lineBreakMode = .byWordWrapping
        self.dateLabel.numberOfLines = 0
    }
    
    func buildaddressLabel() {
        self.addSubview(self.addressLabel)
        self.addressLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addressLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10).isActive = true
        self.addressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.addressLabel.lineBreakMode = .byWordWrapping
        self.addressLabel.numberOfLines = 0
    }
}
