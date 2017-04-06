//
//  Buttons.swift
//  TeamOrange
//
//  Created by Michael on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class LoginButton: UIButton {
    
    let buttonImageView = UIImageView()
    
    init(title: String, image: UIImage?, backgroundColor: UIColor) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = backgroundColor
        self.buttonImageView.image = image
        self.setTitle(title, for: .normal)
        self.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressed() {
        print("Login button pressed")
    }
    
    func buttonImageConstraint() {
        
    }
    
}



