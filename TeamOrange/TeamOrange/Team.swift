////
////  Team.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation
import UIKit


class Team {
    
    var color: UIColor?
    var homeField: String?
    let id: String
    var imageUrlString: String?
    var image: UIImage?
    var name: String
    
    // Arrays not created at initialization
    var captain: [Player]?
    var players: [Player]?
    
    init(id: String, dict: [String: Any]) {
        self.id = id
        self.color = dict["color"] as? UIColor
        self.homeField = dict["homeField"] as? String
        self.imageUrlString = dict["imageUrlString"] as? String
        self.name = dict["name"] as? String ?? ""
    }
}

extension Team: CustomStringConvertible {
    
    var description: String {
        return "ID: \(self.id) with name of: \(self.name)\n"
    }
    
}
 

