////
////  User.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////



import Foundation


class Player {
    
    
    var birthDate: String?
    
    var email: String?
    var favSport: Sport?
    var gender: Gender?
    var homeField: String?
    var homeTown: String?
    var id: String
    var imageUrlString: String?
    var name: String?
    var phone: String?
    var zipCode: String?
    
    // Arrays of classes not initialized at instantiation
    var adminOf: [Game]?
    var captainOf: [Team]?
    var friends: [Player]?
    var games: [Game]?
    var teams: [Team]?
    
    init(id: String, dict: [String:Any]) {
        self.id = id
        self.birthDate = dict["birthDate"] as? String
        self.email = dict["email"] as? String
        self.favSport = dict["favSport"] as? Sport
        self.gender = dict["gender"] as? Gender
        self.homeField = dict["homeField"] as? String
        self.homeTown = dict["homeTown"] as? String
        self.imageUrlString = dict["imageUrlString"] as? String
        self.name = dict["name"] as? String
        self.phone = dict["phone"] as? String
        self.zipCode = dict["zipCode"] as? String
    }
}

extension Player: CustomStringConvertible {
    
    var description: String {
        return "ID: \(self.id) with name of: \(self.name)\n"
    }
    
}

