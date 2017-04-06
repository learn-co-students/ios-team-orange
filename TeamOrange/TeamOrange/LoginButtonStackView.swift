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
    let facebookLoginBtn = LoginButton(title: "f", image: nil, backgroundColor: .blue)
    let twitterLoginBtn = LoginButton(title: "t", image: nil, backgroundColor: .cyan)
    let gmailBtn = LoginButton(title: "G", image: nil, backgroundColor: .red)
}
