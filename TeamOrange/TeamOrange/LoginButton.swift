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
    
    var myImageView = UIImageView()
    
    init(image: UIImage?) {
        super.init(frame: CGRect.zero)
        self.myImageView.image = image
        self.addTarget(self, action: #selector(self.pressed), for: .touchUpInside)
        self.myImageView.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressed() {
        print("Login button pressed")
    }
}
