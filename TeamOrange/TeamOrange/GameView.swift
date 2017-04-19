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
    var sportIcon = UIImageView()
    var nameLabel = UILabel()
    var addressLabel = UILabel()
    var dateLabel = UILabel()
    var stateLabel = UILabel()
    var playersLabel = UILabel()
    var labels: [UILabel] = []
    
    weak var delegate: GameViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        self.labels = [self.nameLabel, self.addressLabel, self.dateLabel, self.stateLabel, self.playersLabel]
        self.buildView()
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        self.labels.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.lineBreakMode = .byWordWrapping
            $0.numberOfLines = 0
        }
        self.buildNameLabel()
        self.buildaddressLabel()
        self.buildDateLabel()
        self.buildStateLabel()
        self.buildPlayersLabel()
        self.buildCollectionView()
        self.buildSportIcon()
    }
    
    func buildNameLabel() {
        self.nameLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        self.nameLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func buildaddressLabel() {
        self.addressLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.addressLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func buildSportIcon() {
        self.addSubview(self.sportIcon)
        self.sportIcon.translatesAutoresizingMaskIntoConstraints = false
        self.sportIcon.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 10).isActive = true
//        self.sportIcon.bottomAnchor.constraint(equalTo: self.addressLabel.topAnchor, constant: -5).isActive = true
        self.sportIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        self.sportIcon.widthAnchor.constraint(equalTo: self.sportIcon.heightAnchor).isActive = true
//        self.sportIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        self.sportIcon.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.sportIcon.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
        self.sportIcon.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.5).isActive = true
    }
    
    func buildDateLabel() {
        self.dateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        self.dateLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -5).isActive = true
    }
    
    func buildStateLabel() {
        self.stateLabel.topAnchor.constraint(equalTo: self.nameLabel.bottomAnchor).isActive = true
        self.stateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
    }
    
    func buildPlayersLabel() {
        self.playersLabel.topAnchor.constraint(equalTo: self.addressLabel.bottomAnchor, constant: 5).isActive = true
        self.playersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    }
    
    func buildCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 10)
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width / 5, height: UIScreen.main.bounds.width / 5)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        
        self.collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "playerCell")
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.playersLabel.bottomAnchor, constant: 5).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        self.collectionView.backgroundColor = self.backgroundColor
    }
}
