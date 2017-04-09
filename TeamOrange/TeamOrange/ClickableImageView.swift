//
//  ClickableImage.swift
//  TeamOrange
//
//  Created by William Brancato on 4/8/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class ClickableImage: UIImageView {
    
    var gestureRecognizer: UITapGestureRecognizer!
    let sport: Sport
    
    init(sport: Sport, image: UIImage?) {
        self.sport = sport
        super.init(image: image)
        self.image = image
        self.isUserInteractionEnabled = true
        self.gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.tapped))
        self.addGestureRecognizer(gestureRecognizer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func tapped() {
        let notification = Notification(name: Notification.Name("Sport Chosen"), object: self.sport, userInfo: nil)
        NotificationCenter.default.post(notification)
    }
    
}
