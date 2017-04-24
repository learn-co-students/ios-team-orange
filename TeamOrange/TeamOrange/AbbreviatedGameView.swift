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
            self.buildDateLabel()
            self.buildSportIcon()
            self.buildPlayersLabel()
            self.buildCollectionView()
        }
    }
    
    var collectionView: UICollectionView!
    var gamePeekDelegate: GamePeekScrollerDelegate!
    var sportIcon: UIImageView!
    var dateLabel: WhiteFontLabel!
    var playersLabel: WhiteFontLabel!
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
    
    func buildDateLabel() {
        self.dateLabel = WhiteFontLabel(withTitle: self.game.dateString)
        self.addSubview(self.dateLabel)
        self.dateLabel.translatesAutoresizingMaskIntoConstraints = false
        self.dateLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.dateLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.dateLabel.lineBreakMode = .byWordWrapping
        self.dateLabel.numberOfLines = 0
    }
    
    func buildSportIcon() {
        self.sportIcon = UIImageView(image: self.game.sport?.image.image)
        self.addSubview(self.sportIcon)
        self.sportIcon.translatesAutoresizingMaskIntoConstraints = false
        self.sportIcon.topAnchor.constraint(equalTo: self.topAnchor, constant: 25).isActive = true
        self.sportIcon.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -5).isActive = true
        self.sportIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.sportIcon.widthAnchor.constraint(equalTo: self.sportIcon.heightAnchor).isActive = true
        
    }
    
    func buildPlayersLabel() {
        self.playersLabel = WhiteFontLabel(withTitle: "Players: \(self.game.players.count) / \(self.game.maxPlayers)")
        self.addSubview(self.playersLabel)
        self.playersLabel.translatesAutoresizingMaskIntoConstraints = false
        self.playersLabel.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.playersLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.playersLabel.lineBreakMode = .byWordWrapping
        self.playersLabel.numberOfLines = 0
    }
    
    func setPlayersLabelText() {
        self.playersLabel.text = "Players: \(self.game.players.count) / \(self.game.maxPlayers)"
    }
}
