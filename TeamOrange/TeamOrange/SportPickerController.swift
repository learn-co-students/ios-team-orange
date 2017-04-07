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
    var widthConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        self.slideViewIn()
    }
    
    
    func buildView() {
        self.view.addSubview(self.myView)
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.myView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        
        leadingConstraint = self.myView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor)
        leadingConstraint.isActive = true
//
//        widthConstraint = self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4)
//        widthConstraint.isActive = true
        
    }
    
    func slideViewIn() {
//        print(self.widthConstraint.constant)
//        let width = self.view.frame.size.width * 0.4
//        self.leadingConstraint.constant.subtract(width)

        UIView.animate(withDuration: 3, animations: {
            self.leadingConstraint.constant.subtract(-(self.view.frame.size.width * 0.4))
//            self.myView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -(self.view.frame.size.width * 0.4)).isActive = true
          //  self.myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
            self.view.layoutIfNeeded()
        }, completion: { _ in
            print("Done")
        })
    }
    
}
