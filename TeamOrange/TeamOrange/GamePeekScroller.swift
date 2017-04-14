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
    
    init(games: [Game], delegate: UICollectionViewDataSource & UICollectionViewDelegate) {
        self.games = games
        super.init(frame: CGRect.zero)
        self.setupStack(delegate: delegate)
        self.isPagingEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStack(delegate: UICollectionViewDelegate & UICollectionViewDataSource) {
        var gameViews: [AbbreviatedGameView] = []
        self.games.forEach { gameViews.append(AbbreviatedGameView(game: $0, delegate: delegate))}
        self.gameStack = UIStackView(arrangedSubviews: gameViews)
        self.gameStack.addAndConstrainToEdges(of: self)
        gameViews.forEach {
            $0.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
}
