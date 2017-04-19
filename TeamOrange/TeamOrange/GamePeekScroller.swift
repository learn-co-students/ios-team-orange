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
    var gamePeekDelegate: GamePeekScrollerDelegate!
    
    init() {
        super.init(frame: CGRect.zero)
        self.isPagingEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStack() {
        var gameViews: [AbbreviatedGameView] = []
        for num in 0..<self.gamePeekDelegate.games.count {
            let abbreviatedGameView = AbbreviatedGameView(delegate: self.gamePeekDelegate)
            abbreviatedGameView.game = self.gamePeekDelegate.games[num]
            abbreviatedGameView.collectionView.tag = num
            abbreviatedGameView.tag = num + 100
            gameViews.append(abbreviatedGameView)
            
        }
        self.gameStack = UIStackView(arrangedSubviews: gameViews)
        self.gameStack.distribution = .fillEqually
        self.gameStack.alignment = .fill
        self.gameStack.addAndConstrainToEdges(of: self)
        gameViews.forEach {
            $0.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
}
