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
    
    override open func viewDidLoad() {
        self.buildStaticNavBar()
    }
    
    func buildStaticNavBar() {
        self.buildMapButton()
        self.setNavBarTitle()
        self.navigationBar.backgroundColor = UIColor.lightGray
        self.navigationBar.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    func buildMapButton() {
        let mikesFavFont = UIFont(name: "SFSportsNight", size: 20)
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: mikesFavFont]
        let sportsButton = UIBarButtonItem(title: "Map", style: .plain, target: self, action: #selector(goToSportPicker) )
        sportsButton.setTitleTextAttributes([NSFontAttributeName : mikesFavFont], for: .normal)
        self.topViewController?.navigationItem.setRightBarButton(sportsButton, animated: false)
    }
    
    func setNavBarTitle() {
        let mikesFavFont = UIFont(name: "SFSportsNight", size: 20)
        self.navigationBar.titleTextAttributes = [NSFontAttributeName: mikesFavFont]
        self.title = "Team Up"
        self.navigationItem.title = "anything"
        print("I tried to set the title, hope it worked")
    }
    
    func goToSportPicker() {
        self.popToRootViewController(animated: false)
    }
}
