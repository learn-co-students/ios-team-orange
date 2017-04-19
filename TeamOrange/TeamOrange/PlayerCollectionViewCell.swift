//
//  PlayerCollectionViewCell.swift
//  TeamOrange
//
//  Created by William Brancato on 4/13/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerCollectionViewCell: UICollectionViewCell {
    
    let imageView = UIImageView(image: #imageLiteral(resourceName: "runner"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.buildCell()
        self.imageView.addAndConstrainToEdges(of: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildCell() {
        
    }
    
}
