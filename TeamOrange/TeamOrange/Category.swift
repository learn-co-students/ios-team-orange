//
//  Category.swift
//  TeamOrange
//
//  Created by William Brancato on 4/5/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

enum Category: String {
    
    case players
    case games
    case teams
    case admins
    case captains
    case friends
    case captainedTeams = "captainOf"
    case adminnedGames = "adminOf"
    
    var type: String {
        switch self {
        case .players: return "players"
        case .games: return "games"
        case .teams: return "teams"
        case .admins: return "players"
        case .captains: return "players"
        case .friends: return "players"
        case .captainedTeams: return "teams"
        case .adminnedGames: return "games"
        }
    }
    
}
