//
//  RoundSingleCorners.swift
//  TeamOrange
//
//  Created by William Brancato on 4/12/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit



extension UIView {
    func roundCorners(corners:UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}

