//
//  PlayerController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerController: UIViewController, PlayerViewDelegate {
    
    let myView: PlayerView = PlayerView()
    var player: Player! {
        didSet {
            self.myView.delegate = self
            self.myView.buildView()
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.buildStaticNavBar()
        self.myView.addAndConstrainToEdges(of: self.view)
    }
}
