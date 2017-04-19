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
    var viewArray: [UIView] = []
    
    init() {
        super.init(frame: CGRect.zero)
        self.viewArray = [self.sportsTextLabel, self.backButton, self.sportsNumberLabel, self.radiusSlider, self.radiusTextLabel, self.radiusNumberLabel]
        self.blur.addAndConstrainToEdges(of: self)
        self.buildNumSportsLabels()
        self.buildRadiusSlider()
        self.buildRadiusLabels()
        self.viewArray.forEach{ $0.alpha = 0 }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
    
    func radiusSliderChanged() {
        self.radiusNumberLabel.text = String(Int(self.radiusSlider.value))
    }
    
}
