//
//  MapGradientView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/12/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit


//TODO: Play around and see you can get it to work
class MapGradientView: UIView {
    
    init(){
        super.init(frame: CGRect.zero)
        let mask = CAGradientLayer()
        mask.startPoint = CGPoint(x: 0, y: 0)
        mask.endPoint = CGPoint(x: 0, y: 0.1)
        let whiteColor = UIColor.white
        mask.colors = [whiteColor.withAlphaComponent(0.0).cgColor,whiteColor.withAlphaComponent(0.0),whiteColor.withAlphaComponent(1.0).cgColor]
        mask.locations = [NSNumber(value: 0.0),NSNumber(value: 0.2),NSNumber(value: 1.0)]
        mask.frame = self.bounds
        self.layer.mask = mask
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
