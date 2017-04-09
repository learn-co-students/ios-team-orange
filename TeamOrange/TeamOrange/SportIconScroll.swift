//
//  SportIconStack.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportIconScroll: UIScrollView {
    
    var sportStack: UIStackView!
    var sportIcons: [UIImageView] = []
    
    init() {
        super.init(frame: CGRect.zero)
        Sport.all.forEach { self.sportIcons.append($0.image) }
        self.setupStack()
        self.isPagingEnabled = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupStack() {
        self.sportStack = UIStackView(arrangedSubviews: self.sportIcons)
        self.sportStack.addAndConstrainToEdges(of: self)
        self.sportIcons.forEach {
            $0.contentMode = .scaleAspectFit
            $0.heightAnchor.constraint(equalTo:self.heightAnchor).isActive = true
            $0.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        }
    }
}
