//
//  RandomColor.swift
//  TeamOrange
//
//  Created by William Brancato on 4/13/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    static func random() -> UIColor {
        let red = CGFloat(arc4random_uniform(256)) / CGFloat(255)
        let blue = CGFloat(arc4random_uniform(256)) / CGFloat(255)
        let green = CGFloat(arc4random_uniform(256)) / CGFloat(255)
        return UIColor(red: red, green: green, blue: blue, alpha: 1)
    }
    
    static let runnerBlue = UIColor(red: 66/255, green: 77/255, blue: 125/255, alpha: 1)
    
}
