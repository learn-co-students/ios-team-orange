////
////  Game.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation


 class Game {

    let id: String
    var players: [Player]?
    var date: String //TODO: change to NSDate
    var sport: Sport?
    var name: String?
    var success: Bool?
    var over: Bool?
    let admin: Player
    let state: GameState?
    
    var numPlayers: Int? {
        guard let players = self.players else { return nil }
        return players.count
    }
    
    init(id: String, dict: [String:Any]) {
        self.id = id
        self.date = dict["date"] as? String ?? ""
        self.sport = dict ["sport"] as? Sport
        self.name = dict["name"] as? String
        self.success = dict["success"] as? Bool ?? false //TODO: Should we be defaulting to false?
        self.over = dict["over"] as? Bool ?? false //TODO: Should we ve defaulting to false?
        self.admin = FirebaseClient.getAdminFor(gameId: self.id)
        self.state = dict["gameState"] as? GameState
    }
    
    func getPlayers() {
        self.players = FirebaseClient.getPlayersFor(gameId: self.id)
    }
    
 }

extension Game: CustomStringConvertible {
    
    var description: String {
        return "game: \(self.name)"
    }
    
}

