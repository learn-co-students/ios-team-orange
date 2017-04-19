////
////  Game.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation


class Game {
    
    var date: String //TODO: add func to convert to NSDate
    let id: String
    var name: String
    var isOver: Bool?
    var sport: Sport? // should not be optional, changing for testing purposes
    let state: GameState? // should not be optional, changing for testing purposes
    var success: Bool?
    var maxPlayers: Int
    
    var numPlayers: Int {
        return players.count
    }
    
    // Arrays not created at initialization
    var admins: [Player] = []
    var players: [Player] = []
    
    init(id: String, dict: [String:Any]) {
        self.id = id
        self.date = dict["date"] as? String ?? ""
        if let sportString = dict ["sport"] as? String {
            self.sport = Sport(rawValue: sportString)
        }
        self.maxPlayers = dict["maxPlayers"] as? Int ?? 0
        self.name = dict["name"] as? String ?? ""
        self.success = dict["success"] as? Bool ?? false //TODO: Should we be defaulting to false?
        self.isOver = dict["over"] as? Bool ?? false //TODO: Should we ve defaulting to false?
        if let stateString = dict["state"] as? String{
            self.state = GameState(rawValue: stateString)
        }else { self.state = nil }
    }
    
    func fillArrays(completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        QueryFirebase.forPlayersIn(game: self, completion: {
            self.players = $0
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        QueryFirebase.forAdminsOf(game: self, completion: {x
            self.admins = $0
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    func containsPlayer(withId playerId: String) -> Bool {
        var playerInGame: Bool = false
        for player in self.players {
            if player.id == playerId {
                playerInGame = true
                break
            }
        }
        return playerInGame
    }
    
}

extension Game: CustomStringConvertible {
    
    var description: String {
        return "ID: \(self.id) with name of: \(self.name)\n"
    }
    
}

