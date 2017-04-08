//
//  SportsPickerCenterView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerCenterView: BlurView {
    
    let sportScroller = SportIconScroll()
    
    override init(blurEffect: UIBlurEffectStyle) {
        super.init(blurEffect: blurEffect)
        self.sportScroller.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
