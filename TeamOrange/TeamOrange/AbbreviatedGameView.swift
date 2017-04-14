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
    
    init(game: Game) {
        self.game = game
        super.init(frame: CGRect.zero)
        self.buildCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCollectionView() {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.scrollDirection = .vertical
        
        self.collectionView = UICollectionView(frame: CGRect(x: self.frame.width * 0.2,
                                                             y: 150 * 0.2,
            width: self.frame.width,
            height: 150 * 0.6),
            collectionViewLayout: layout)
        
        self.collectionView.register(PlayerCollectionViewCell.self, forCellWithReuseIdentifier: "playerCell")
        self.collectionView.backgroundColor = self.backgroundColor
        self.addSubview(self.collectionView)
    }
}
