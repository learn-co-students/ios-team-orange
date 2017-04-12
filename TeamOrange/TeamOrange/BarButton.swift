//
//  BarButton.swift
//  TeamOrange
//
//  Created by William Brancato on 4/12/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationController {
    
    func makeButton() {
        let font = UIFont(name: "SFSportsNight", size: 20)
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: font]
        let sportsButton = UIBarButtonItem(title: "Sports", style: .plain, target: self, action: #selector(goToSportPicker) )
        sportsButton.setTitleTextAttributes([NSFontAttributeName : font], for: .normal)
        self.topViewController?.navigationItem.setRightBarButton(sportsButton, animated: false)
    }
    
    func goToSportPicker() {
        self.popToRootViewController(animated: false)
    }
    
}
