//
//  SportPickerTopView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerTopView: UIView {

    let label = UILabel()
    let blur = BlurView(blurEffect: .dark)
    
    init() {
        super.init(frame: CGRect.zero)
        self.blur.addAndConstrainToEdges(of: self)
        self.buildLabel()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildLabel() {
        self.addSubview(self.label)
        self.label.translatesAutoresizingMaskIntoConstraints = false
        self.label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.label.text = "Select Your Sport(s)"
        self.label.textColor = UIColor.white
        self.label.font = self.label.font.withSize(15)
        self.label.numberOfLines = 0
        self.label.lineBreakMode = .byWordWrapping
    }
}
