//
//  ChosenSportCollectionCell.swift
//  TeamOrange
//
//  Created by William Brancato on 4/10/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class ChosenSportCollectionCell: UICollectionViewCell {
    
    var imageView: UIImageView!
    var sport: Sport? { didSet { self.imageView.image = self.sport?.image.image } }
    
    init() {
        super.init(frame: CGRect.zero)
        self.imageView.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
