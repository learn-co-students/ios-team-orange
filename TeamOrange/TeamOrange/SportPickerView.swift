//
//  SportPickerView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/7/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerView: UIView {
    
    let topView = SportPickerTopView(blurEffect: .regular)
    let centerView = SportPickerCenterView(blurEffect: .regular)
    let bottomView = SportPickerBottomView(blurEffect: .regular)
    
    var topViewTopAnchorInvisible: NSLayoutConstraint!
    var topViewBottomAnchorInvisible: NSLayoutConstraint!
    var topViewTopAnchorVisible: NSLayoutConstraint!
    var topViewBottomAnchorVisible: NSLayoutConstraint!
    
    var bottomViewTopAnchorInvisible: NSLayoutConstraint!
    var bottomViewBottomAnchorInvisible: NSLayoutConstraint!
    var bottomViewTopAnchorVisible: NSLayoutConstraint!
    var bottomViewBottomAnchorVisible: NSLayoutConstraint!
    
    var topViewConstraints: [NSLayoutConstraint]!
    var bottomViewConstraints: [NSLayoutConstraint]!
    
    init() {
        super.init(frame: CGRect.zero)
        self.buildView()
        self.initializeConstraints()
                self.topView.alpha = 0
                self.bottomView.alpha = 0
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        let views: [UIView] = [self.topView, self.centerView, self.bottomView]
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
            $0.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        }
        self.centerView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.centerView.heightAnchor.constraint(equalTo: self.centerView.widthAnchor).isActive = true
    }
    
    func initializeConstraints() {
        self.topViewTopAnchorVisible = self.topView.topAnchor.constraint(equalTo: self.topAnchor); self.topViewTopAnchorVisible.isActive = false
        self.topViewBottomAnchorVisible = self.topView.bottomAnchor.constraint(equalTo: self.centerView.topAnchor); self.topViewBottomAnchorVisible.isActive = false
        self.bottomViewTopAnchorVisible = self.bottomView.topAnchor.constraint(equalTo: self.centerView.bottomAnchor); self.bottomViewTopAnchorVisible.isActive = false
        self.bottomViewBottomAnchorVisible = self.bottomView.bottomAnchor.constraint(equalTo: self.bottomAnchor); self.bottomViewBottomAnchorVisible.isActive = false
        
        self.topViewTopAnchorInvisible = self.topView.topAnchor.constraint(equalTo: self.centerView.topAnchor); self.topViewTopAnchorInvisible.isActive = true
        self.topViewBottomAnchorInvisible = self.topView.bottomAnchor.constraint(equalTo: self.centerView.bottomAnchor); self.topViewBottomAnchorInvisible.isActive = true
        self.bottomViewTopAnchorInvisible = self.bottomView.topAnchor.constraint(equalTo: self.centerView.topAnchor); self.bottomViewTopAnchorInvisible.isActive = true
        self.bottomViewBottomAnchorInvisible = self.bottomView.bottomAnchor.constraint(equalTo: self.centerView.bottomAnchor); self.bottomViewBottomAnchorInvisible.isActive = true
        
        self.topViewConstraints = [self.topViewTopAnchorVisible, self.topViewBottomAnchorVisible, self.topViewTopAnchorInvisible, self.topViewBottomAnchorInvisible]
        self.bottomViewConstraints = [self.bottomViewTopAnchorVisible, self.bottomViewBottomAnchorVisible, self.bottomViewTopAnchorInvisible, self.bottomViewBottomAnchorInvisible]
    }
    
    func build() {
        self.flipConstraints(constraints: self.bottomViewConstraints)
        self.flipConstraints(constraints: self.topViewConstraints)
        UIView.animate(withDuration: 0.25, animations: {
            self.topView.alpha = 1
            self.bottomView.alpha = 1
            self.layoutIfNeeded()
        })
    }
    
    func collapse() {
        self.flipConstraints(constraints: self.bottomViewConstraints)
        self.flipConstraints(constraints: self.topViewConstraints)
        UIView.animate(withDuration: 0.25, animations: {
            self.topView.alpha = 0
            self.bottomView.alpha = 0
            self.layoutIfNeeded()
        }, completion: { _ in
                let notification = Notification(name: Notification.Name("Picker Collapsed"), object: nil, userInfo: nil)
                NotificationCenter.default.post(notification)
        })
    }
    
    func flipConstraints(constraints: [NSLayoutConstraint]) {
        constraints.forEach {
            if $0.isActive == true { $0.isActive = false }
            else { $0.isActive = true }
        }
    }
}
