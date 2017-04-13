////
////  Game.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation


 class Game {
    
    var date: String //TODO: change to NSDate
    let id: String
    var name: String?
    var over: Bool?
    var sport: Sport? // should not be optional, changing for testing purposes
    let state: GameState? // should not be optional, changing for testing purposes
    var success: Bool?
    
    var numPlayers: Int? {
        guard let players = self.players else { return nil }
        return players.count
    }
    
    // Arrays not created at initialization
    var admins: [Player]?
    var players: [Player]?
    
    init(id: String, dict: [String:Any]) {
        self.id = id
        self.date = dict["date"] as? String ?? ""
        self.sport = dict ["sport"] as? Sport
        self.name = dict["name"] as? String
        self.success = dict["success"] as? Bool ?? false //TODO: Should we be defaulting to false?
        self.over = dict["over"] as? Bool ?? false //TODO: Should we ve defaulting to false?
        self.state = dict["gameState"] as? GameState
        
        
        
    }
    
 }

extension Game: CustomStringConvertible {
    
    var description: String {
        return "ID: \(self.id) with name of: \(self.name)\n"
    }
    
}

