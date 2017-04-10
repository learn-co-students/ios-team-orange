//
//  SportPickerBottom.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerBottomView: UIView {
    
    let backButton = UIButton()
    let sportsTextLabel = WhiteFontLabel(withTitle: "# Of Sports Selected")
    let sportsNumberLabel = WhiteFontLabel(withTitle: "0")
    let blur = BlurView(blurEffect: .dark)
    let radiusSlider = UISlider()
    let radiusTextLabel = WhiteFontLabel(withTitle: "Search Radius")
    let radiusNumberLabel = WhiteFontLabel(withTitle: "5")
    
    
     init() {
    super.init(frame: CGRect.zero)
        self.blur.addAndConstrainToEdges(of: self)
        self.buildNumSportsLabels()
        self.buildBackButton()
        self.buildRadiusSlider()
        self.buildRadiusLabels()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildBackButton() {
        self.addSubview(self.backButton)
        self.backButton.translatesAutoresizingMaskIntoConstraints = false
        self.backButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -10).isActive = true
        self.backButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.backButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.25).isActive = true
        self.backButton.heightAnchor.constraint(equalTo: self.backButton.widthAnchor).isActive = true
        self.backButton.setImage(#imageLiteral(resourceName: "rightArrow"), for: .normal)
        self.backButton.addTarget(self, action: #selector(self.backButtonTapped), for: .touchUpInside)
    }
    
    func buildNumSportsLabels() {
        self.addSubview(self.sportsTextLabel)
        self.sportsTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sportsTextLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.sportsTextLabel.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: 50).isActive = true
        
        self.addSubview(self.sportsNumberLabel)
        self.sportsNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.sportsNumberLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.sportsNumberLabel.topAnchor.constraint(equalTo: self.sportsTextLabel.bottomAnchor, constant: 5).isActive = true
    }
    
    func buildRadiusLabels() {
        self.addSubview(self.radiusTextLabel)
        self.radiusTextLabel.translatesAutoresizingMaskIntoConstraints = false
        self.radiusTextLabel.bottomAnchor.constraint(equalTo: self.radiusSlider.topAnchor).isActive = true
        self.radiusTextLabel.centerXAnchor.constraint(equalTo: self.radiusSlider.centerXAnchor).isActive = true
        
        self.addSubview(self.radiusNumberLabel)
        self.radiusNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        self.radiusNumberLabel.topAnchor.constraint(equalTo: self.radiusSlider.bottomAnchor).isActive = true
        self.radiusNumberLabel.centerXAnchor.constraint(equalTo: self.radiusSlider.centerXAnchor).isActive = true
    }
    
    func buildRadiusSlider() {
        self.addSubview(self.radiusSlider)
        self.radiusSlider.translatesAutoresizingMaskIntoConstraints = false
        self.radiusSlider.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.radiusSlider.topAnchor.constraint(equalTo: self.centerYAnchor, constant: -50).isActive = true
        self.radiusSlider.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        self.radiusSlider.addTarget(self, action: #selector(self.radiusSliderChanged), for: .valueChanged)
        self.radiusSlider.maximumValue = 50
        self.radiusSlider.minimumValue = 0
        self.radiusSlider.value = 5
    }
    
    func backButtonTapped() {
        let notification = Notification(name: Notification.Name("Collapse Picker"), object: nil, userInfo: nil)
        NotificationCenter.default.post(notification)
    }
    
    func radiusSliderChanged() {
        self.radiusNumberLabel.text = String(Int(self.radiusSlider.value))
    }
    
}
