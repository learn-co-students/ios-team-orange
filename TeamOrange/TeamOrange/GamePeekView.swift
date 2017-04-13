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
    
    init() {
        super.init(frame: CGRect.zero)
        self.blurView.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
