////
////  User.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////
//
//import Foundation
//
//class User { 
//    
//    var userName: String
//    var profPic: String?
//    var gender: Gender?
//    let birthDate: String?
//    var homeTown: String?
//    var zipCode: Int
//    var favSport: Sport?
//    var homeField: Location?
//    var favLocations: [Location]?
//    var friends: [User]?
//    var teams: [Team]?
//    var games: [Game]?
//    
//    init?(userDict: [String:Any]) {
//        guard let userName = userDict["userName"] as? String else {print("Username not valid"); return nil}
//        self.userName = userName
//        
//        self.profPic = userDict["profPic"] as? String ?? "Profile pic URL not valid"
//        
//        guard let gender = userDict["gender"] as? Gender else {print("Gender not valid");return nil}
//        self.gender = gender
//        
//        self.birthDate = userDict["birthDate"] as? String ?? "Birthdate not valid"
//        
//        guard let homeTown = userDict["homeTown"] as? String else {print("Hometown not valid");return nil}
//        self.homeTown = homeTown
//        
//        self.zipCode = userDict["zipCode"] as? Int ?? 0
//        
//        guard let favSport = userDict["favSport"] as? Sport else {print("Favorite sport not found"); return nil}
//        self.favSport = favSport
//        
//        self.homeField = userDict["homeField"] as? Location ?? nil
//    }
//}
