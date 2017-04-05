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
    let id: String
    var name: String
    var users: [Player]?
    var profPic: UIImage?
    var profPicUrl: String?
    weak var homeField: Location?
    var numberGamesPlayed: Int
    //TODO: compute successful & unsuccessful games from this property
    weak var captain: Player?
    var coCaptains: [Player]?
    var color: UIColor?
    
    init? (id: String, dict: [String: Any]) {
        self.id = id
        self.name = dict["name"] as? String ?? ""
        self.users =  dict["players"] as? [Player] ?? nil
        self.profPic = nil
        self.profPicUrl = dict["profPic"] as? String ?? nil
        if let games = dict["game"] as? [String : Any] {
            numberGamesPlayed = games.count
        } else {numberGamesPlayed = 0}
        if let captName = dict["captain"] as? String {
            captain = FirebaseClient.getCaptainFor(teamId: self.id) //TODO: Implement
        }
        color = dict["color"] as? UIColor
    }
}
 

