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
    
    func fillArrays(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        QueryFirebase.forAdminnedGamesOf(player: self, completion: { adminnedGames in
            self.adminOf = adminnedGames
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        QueryFirebase.forCaptainedTeamsOf(player: self, completion: { captainedTeams in
            self.captainOf = captainedTeams
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        QueryFirebase.forFriendsOf(player: self, completion: { friends in
            self.friends = friends
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        QueryFirebase.forGamesOf(player: self, completion: { games in
            self.games = games
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        QueryFirebase.forTeamsOf(player: self, completion: { teams in
            self.teams = teams
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: DispatchQueue.main) { 
            completion()
        }
    }
}

extension Player: CustomStringConvertible {
    
    var description: String {
        return "ID: \(self.id) with name of: \(self.name)\n"
    }
    
}

