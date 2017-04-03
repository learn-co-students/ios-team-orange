//
//  Game.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

class Game {
    
    let id: String
    var location: Location
    var players: [User]?
    var date: String //TODO: change to NSDate
    var sport: Sport
    var name: String?
    var success: Bool
    var over: Bool
    let admin: User
    let state: GameState
    
    var numPlayers: Int? {
        guard let players = self.players else { return nil }
        return players.count
    }
    
    init(id: String, dict: [String:Any]) {
        self.id = id
        self.location = FirebaseClient.getLocationFor(gameId: id)
        self.date = dict["date"] as? String ?? ""
        
        guard let sportString = dict["sport"] as? String
            , let sport = Sport(rawValue: sportString) else { return }
        self.sport = sport
        
        self.name = dict["name"] as? String
        self.success = dict["success"] as? Bool ?? false //TODO: Should we be defaulting to false?
        self.over = dict["over"] as? Bool ?? false //TODO: Should we ve defaulting to false?
        self.admin = FirebaseClient.getAdminFor(gameId: self.id) //TODO: should we make two seperate API Calls for admin and location?
        
        guard let gameStateString = dict["gameState"] as? String
            , let gameState = GameState(rawValue: gameStateString) else { return }
        self.state = gameState
    }
    
    func getPlayers() {
        self.players = FirebaseClient.getUsersFor(gameId: self.id)
    }
    
}
