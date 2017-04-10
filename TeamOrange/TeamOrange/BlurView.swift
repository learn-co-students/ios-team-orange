//
//  BlurView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class BlurView: UIView {
    
    var blurView: UIVisualEffectView
    
    init(blurEffect: UIBlurEffectStyle) {
        let blurEffect = UIBlurEffect(style: blurEffect)
        self.blurView = UIVisualEffectView(effect: blurEffect)
        super.init(frame: CGRect.zero)
        self.alpha = 0.5
        self.buildBlur()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildBlur() {
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
    }
}
