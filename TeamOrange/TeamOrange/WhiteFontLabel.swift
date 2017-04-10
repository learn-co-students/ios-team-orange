//
//  WhiteFontLabel.swift
//  TeamOrange
//
//  Created by William Brancato on 4/10/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class WhiteFontLabel: UILabel {
    
    init(withTitle text: String) {
        super.init(frame: CGRect.zero)
        self.text = text
        self.textColor = UIColor.white
        self.font = self.font.withSize(15)
        self.numberOfLines = 0
        self.lineBreakMode = .byWordWrapping
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
