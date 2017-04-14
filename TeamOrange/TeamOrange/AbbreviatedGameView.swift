//
//  AbbreviatedGameView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/13/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class AbbreviatedGameView: UIView {
    
    var game: Game! {
        didSet {
            self.buildTitleLabel()
            self.buildSportIcon()
            self.buildTitleLabel()
            self.buildDateLabel()
            self.buildPlayersLabel()
            self.buildCollectionView()
        }
    }
    var collectionView: UICollectionView!
    var gamePeekDelegate: GamePeekScrollerDelegate!
    var sportIcon: UIImageView!
    var titleLabel: WhiteFontLabel!
    var playersLabel: WhiteFontLabel!
    var dateLabel: WhiteFontLabel!
    var admin = UIImageView()
    
    init(delegate: GamePeekScrollerDelegate) {
        self.gamePeekDelegate = delegate
        super.init(frame: CGRect.zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 30, height: 30)
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        self.collectionView.delegate = self.gamePeekDelegate
        self.collectionView.dataSource = self.gamePeekDelegate
        
        self.collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "playerCell")
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.playersLabel.bottomAnchor, constant: 5).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.collectionView.backgroundColor = self.backgroundColor
    }
    
    func buildTitleLabel() {
        self.titleLabel = WhiteFontLabel(withTitle: self.game.name)
        self.addSubview(self.titleLabel)
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.titleLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.titleLabel.lineBreakMode = .byWordWrapping
        self.titleLabel.numberOfLines = 0
    }
    
    func buildSportIcon() {
        self.sportIcon = UIImageView(image: self.game.sport?.image.image)
        self.addSubview(self.sportIcon)
        self.sportIcon.translatesAutoresizingMaskIntoConstraints = false
        self.sportIcon.topAnchor.constraint(equalTo: self.titleLabel.bottomAnchor).isActive = true
        self.sportIcon.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        self.sportIcon.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1/3).isActive = true
        self.sportIcon.widthAnchor.constraint(equalTo: self.sportIcon.heightAnchor).isActive = true
    }
    
    //TODO: Build this out
    func buildDateLabel() {
        self.dateLabel = WhiteFontLabel(withTitle: self.game.date)
        self.addSubview(self.dateLabel)
        
        
    }
    
    func buildPlayersLabel() {
        self.playersLabel = WhiteFontLabel(withTitle: "Players: \(self.game.players?.count)")
        self.addSubview(self.playersLabel)
        self.playersLabel.translatesAutoresizingMaskIntoConstraints = false
        self.playersLabel.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.playersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.playersLabel.lineBreakMode = .byWordWrapping
        self.playersLabel.numberOfLines = 0
    }
    
}
