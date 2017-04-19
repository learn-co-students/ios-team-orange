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
    
    var chosenSports: [Sport] = []
    let gestureView = UIView()
    
    let myView = SportPickerView()
    var leadingConstraintVisible: NSLayoutConstraint!
    var leadingConstraintInvisible: NSLayoutConstraint!
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        self.buildGestureView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.sportChosen), name: Notification.Name("Sport Chosen"), object: nil)
        NotificationCenter.default.addObserver(self.myView, selector: #selector(self.myView.collapse), name: Notification.Name("Collapse Picker"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.slideViewIn()
    }
    
    func slideViewIn() {
        self.leadingConstraintVisible.isActive = false
        self.leadingConstraintInvisible.isActive = true
        UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() }
            , completion: { _ in self.myView.build() })
    }
    
    func slideViewOut() {
        self.leadingConstraintVisible.isActive = true
        self.leadingConstraintInvisible.isActive = false
        UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() }
            , completion: { _ in
                self.dismiss(animated: false)
                let notification = Notification(name: Notification.Name("Picker Collapsed"), object: nil, userInfo: nil)
                NotificationCenter.default.post(notification)
        })
        
    }
    
    func sportChosen(notification: Notification) {
        guard let sport = notification.object as? Sport else { return }
        if self.chosenSports.contains(sport) {
            for index in 0..<self.chosenSports.count {
                if self.chosenSports[index] == sport {
                    self.chosenSports.remove(at: index)
                    break
                }
            }
        } else {
            self.chosenSports.append(sport)
        }
        self.myView.bottomView.sportsNumberLabel.text = String(self.chosenSports.count)
    }
    
}

extension SportPickerController {
    
    func buildView() {
        self.view.addSubview(self.myView)
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.leadingConstraintVisible = self.myView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor); self.leadingConstraintVisible.isActive = true
        self.leadingConstraintInvisible = self.myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor); self.leadingConstraintInvisible.isActive = false
        self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    //TODO: This view should really reside on SportPickerView
    func buildGestureView() {
        self.view.addSubview(self.gestureView)
        self.gestureView.translatesAutoresizingMaskIntoConstraints = false
        self.gestureView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.gestureView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.gestureView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.gestureView.trailingAnchor.constraint(equalTo: self.myView.leadingAnchor).isActive = true
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.slideViewOut))
        self.gestureView.addGestureRecognizer(gestureRecognizer)
    }
}
