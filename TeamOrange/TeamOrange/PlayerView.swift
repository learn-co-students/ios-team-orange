//
//  PlayerView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerView: UIView {
    
    var imageView: UIImageView!
    
    weak var delegate: PlayerViewDelegate?
    
    init() {
        super.init(frame: CGRect.zero)
        self.backgroundColor = UIColor.white
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildView() {
        print(self.delegate?.player.propertyDictionary)
        self.buildImageView()
    }
    
    func buildImageView() {
        self.imageView = UIImageView(image: #imageLiteral(resourceName: "avatar"))
        self.addSubview(self.imageView)
        self.imageView.translatesAutoresizingMaskIntoConstraints = false
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.imageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.imageView.bottomAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
