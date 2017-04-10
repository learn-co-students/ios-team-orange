//
//  SportsPickerCenterView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerCenterView: UIView {
    
    let sportScroller = SportIconScroll()
    let blur = BlurView(blurEffect: .dark)
    
    init() {
        super.init(frame: CGRect.zero)
        self.blur.addAndConstrainToEdges(of: self)
        self.sportScroller.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
