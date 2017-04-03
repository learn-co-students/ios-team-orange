//
//  User.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

class User {
    
    var userName: String
    let birthDate: String?
    var favLocations: [Location]?
    var favSport: Sport?
    var friends: [User]?
    var games: [Game]?
    var gender: Gender
    var homeField: Location?
    var homeTown: String
    var profPic: String
    var teams: [Team]?
    var zipCode: Int
    
    init?(userDict: [String:Any]) {
        guard let userName = userDict["userName"] as? String else {print("Username not valid"); return nil}
        self.userName = userName
        self.birthDate = userDict["birthDate"] as? String
        self.favLocations = userDict["favLocations"] as? [Location] //TODO: Figure out how to unwrap
        self.favSport = userDict["favSport"] as? String
        self.friends = userDict["friends"] as? [User]
        self.games = userDict["games"] as? [Game]
        self.gender = userDict["gender"] as? Bool
        self.homeField = userDict["gender"] as? String
        self.homeTown = userDict["homeTown"] as? String
        self.profPic = userDict["profPic"] as? String
    }
    
}
