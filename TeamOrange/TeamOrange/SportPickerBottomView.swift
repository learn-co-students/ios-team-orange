//
//  SportPickerBottom.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerBottomView: BlurView {
    
    let backButton = UIButton()
    
    override init(blurEffect: UIBlurEffectStyle) {
        super.init(blurEffect: blurEffect)
        self.buildBackButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildBackButton() {
        self.addSubview(self.backButton)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        self.backButton.heightAnchor.constraint(equalTo: self.backButton.widthAnchor).isActive = true
        self.backButton.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
        self.backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
    }
    
    func backButtonTapped() {
        let notification = Notification(name: Notification.Name("Collapse Picker"), object: nil, userInfo: nil)
        NotificationCenter.default.post(notification)
    }
    
}
