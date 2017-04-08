//
//  SportPickerView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/7/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerView: UIView {
    
    init() {
        super.init(frame: CGRect.zero)
        var darkBlur:UIBlurEffect = UIBlurEffect()
        darkBlur = UIBlurEffect(style: UIBlurEffectStyle.light)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(blurView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
