//
//  GamePeekScroller.swift
//  TeamOrange
//
//  Created by William Brancato on 4/13/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GamePeekScroller: UIScrollView {
    
    var gameStack: UIStackView!
    var games: [Game]
    var collectionViewDelegate: UICollectionViewDelegate!
    
    init(games: [Game]) {
        self.games = games
        super.init(frame: CGRect.zero)
        self.setupStack()
        self.isPagingEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStack() {
        
    }
    
//    func setupStackOld() {
//        self.sportStack = UIStackView(arrangedSubviews: self.sportIcons)
//        self.sportStack.addAndConstrainToEdges(of: self)
//        self.sportIcons.forEach {
//            $0.contentMode = .scaleAspectFit
//            $0.heightAnchor.constraint(equalTo:self.heightAnchor).isActive = true
//            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        }
//    }
}
