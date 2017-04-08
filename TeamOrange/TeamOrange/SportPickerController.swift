//
//  SportPickerController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/7/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerController: UIViewController {
    
    let myView = SportPickerView()
    var leadingConstraint: NSLayoutConstraint!
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.slideViewIn()
    }
    
    
    func buildView() {
        self.view.addSubview(self.myView)
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.leadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        self.leadingConstraint.isActive = true
        self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        
    }
    
    func slideViewIn() {
        self.leadingConstraint.isActive = false
        self.myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() }
                                         , completion: { _ in self.myView.build() })
    }
}
