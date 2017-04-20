//
//  TextFieldShake.swift
//  TeamOrange
//
//  Created by William Brancato on 4/20/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func shake() {
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animation.duration = 0.6
        animation.values = [-20.0, 20.0, -20.0, 20.0, -10.0, 10.0, -5.0, 5.0, 0.0 ]
        layer.add(animation, forKey: "shake")
    }
    
}
