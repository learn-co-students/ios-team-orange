//
//  SportPickerTopView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerTopView: BlurView {
    
    var collectionView: UICollectionView!
    
    override init(blurEffect: UIBlurEffectStyle) {
        super.init(blurEffect: blurEffect)
        self.buildCollectionView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCollectionView() {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: self.frame.size.width / 2, height: self.frame.size.width / 2)
        layout.scrollDirection = .vertical
        
        let rect = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
        
        self.collectionView = UICollectionView(frame: rect, collectionViewLayout: layout)
        self.collectionView.register(ChosenSportCollectionCell.self, forCellWithReuseIdentifier: "cell")
        self.collectionView.addAndConstrainToEdges(of: self)
        self.collectionView.backgroundColor = UIColor.clear
        self.addSubview(self.collectionView)
    }
    
}
