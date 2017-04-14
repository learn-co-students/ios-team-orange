//
//  GameView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/11/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GamePeekView: UIView {
    
    let blurView = BlurView(blurEffect: .dark)
    let gamePeekScroller: GamePeekScroller
    
    init(games: [Game]) {
        self.gamePeekScroller = GamePeekScroller(games: games)
        super.init(frame: CGRect.zero)
        self.blurView.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
