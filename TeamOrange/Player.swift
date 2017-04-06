////
////  User.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////



import Foundation


class Player {
    
    var name: String?
    var image: String?
    var imageUrlString: String?
    var gender: Gender?
    let birthDate: String?
    var homeTown: String?
    var zipCode: Int
    var favSport: Sport?
    var homeField: Location?
    var friends: [Player]?
    var teams: [Team]?
    var games: [Game]?
    var id: String
    
    init(id: String, dict: [String:Any]) {
        self.id = id
        self.name = dict["name"] as? String
        self.image = dict["profPic"] as? String ?? "Profile pic URL not valid"
        self.gender = dict["gender"] as? Gender
        self.birthDate = dict["birthDate"] as? String ?? "Birthdate not valid"
        self.homeTown = dict["homeTown"] as? String
        self.zipCode = dict["zipCode"] as? Int ?? 0
        self.favSport = dict["favSport"] as? Sport
        self.homeField = dict["homeField"] as? Location ?? nil
    }
}

extension Player: CustomStringConvertible {
    
    var description: String {
        return "ID: \(self.id) with name of: \(self.name)\n"
    }
    
}

