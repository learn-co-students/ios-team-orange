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
    
    let game: Game
    var collectionView: UICollectionView!
    let delegate: UICollectionViewDelegate & UICollectionViewDataSource
    var gameIcon: UIImageView?
    let titleLabel: WhiteFontLabel
    let playersLabel = WhiteFontLabel(withTitle: "Players")
    let dateLabel: WhiteFontLabel
    
    
    init(game: Game, delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        self.game = game
        self.titleLabel = WhiteFontLabel(withTitle: self.game.name)
        self.dateLabel = WhiteFontLabel(withTitle: self.game.date)
        if let sport = self.game.sport {
            self.gameIcon = sport.image
        }
        self.delegate = delegate
        super.init(frame: CGRect.zero)
        self.buildCollectionView()
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
        self.collectionView.delegate = self.delegate
        self.collectionView.dataSource = self.delegate
        
        self.collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "playerCell")
        
        self.addSubview(self.collectionView)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        self.collectionView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.collectionView.backgroundColor = self.backgroundColor
    }
    
    
    
}
