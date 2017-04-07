//
//  LoginButtonStackView.swift
//  TeamOrange
//
//  Created by Michael on 4/5/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class LoginButtonStackView: UIStackView {
    
    let facebookLoginBtn = LoginButton(image: #imageLiteral(resourceName: "facebook"))
    let twitterLoginBtn = LoginButton(image: #imageLiteral(resourceName: "twitter"))
    let gmailBtn = LoginButton(image: #imageLiteral(resourceName: "google-plus"))
    
    var loginBtnArray: Array<UIButton> = []
    
    init() {
        self.loginBtnArray = [self.facebookLoginBtn, self.twitterLoginBtn, self.gmailBtn]
        super.init(frame: CGRect.zero)
        self.distribution = .fillEqually
        self.buildLoginStack()
        self.alignment = .fill
        self.spacing = 40
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildLoginStack() {
        loginBtnArray.forEach { (button) in
            self.addArrangedSubview(button)
        }
    }
}
