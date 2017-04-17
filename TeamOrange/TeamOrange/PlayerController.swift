//
//  PlayerController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerController: UIViewController {
    
    var player: Player!
    
    override func viewDidLoad() {
        self.view.backgroundColor = UIColor.red
        dump(self.player)
    }
    
}
