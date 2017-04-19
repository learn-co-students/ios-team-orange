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
    
    init() {
        super.init(frame: CGRect.zero)
        self.buildCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        self.collectionView.topAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.collectionView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.collectionView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.collectionView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.collectionView.backgroundColor = UIColor.white
    }
    
}
