//
//  QueryFirebase.swift
//  TeamOrange
//
//  Created by William Brancato on 4/7/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import FirebaseDatabase

final class QueryFirebase {
    
    fileprivate static let firebase = FIRDatabase.database().reference()
    
    private init() { }
    
    //MARK: Look up model with information
    
    // Find user by displayName
    class func forPlayersWith(name: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, with: "name", of: name) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find users with names that contain a string value
    class func forPlayerNamesContaining(_ value: String, completion: @escaping ([Player]) -> Void) {
        self.getArray(of: .players, with: "name", containing: value) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find user by email
    class func forPlayersWith(email: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, with: "email", of: email) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find user by phone
    class func forPlayersWith(phone: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, with: "phone", of: String(phone)) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find game by game name
    class func forGamesWith(name: String, completion: @escaping ([Game]) -> Void) {
        self.getArrayOf(.games, with: "name", of: name) { (games) in
            if let games = games as? [Game] { completion(games) }
        }
    }
    
    // Find team by team name
    class func forTeamsWith(name: String, completion: @escaping ([Team]) -> Void) {
        self.getArrayOf(.teams, with: "name", of: name) { (teams) in
            if let teams = teams as? [Team] { completion(teams) }
        }
    }
    
    //MARK: Get Info For Player
    
    // Get games for player
    class func forGamesOf(player: Player, completion: @escaping ([Game]) -> Void) {
        self.getArrayOf(.games, from: .players, withId: player.id) { (games) in
            if let games = games as? [Game] { completion(games) }
        }
    }
    
    // Get teams for player
    class func forTeamsOf(player: Player, completion: @escaping ([Team]) -> Void) {
        self.getArrayOf(.teams, from: .players, withId: player.id) { (teams) in
            if let teams = teams as? [Team] { completion(teams) }
        }
    }
    
    // Get friends for player
    class func forFriendsOf(player: Player, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.friends, from: .players, withId: player.id) { (friends) in
            if let friends = friends as? [Player] { completion(friends) }
        }
    }
    
    // Get games a player is an admin of
    class func forAdminnedGamesOf(player: Player, completion: @escaping ([Game]) -> Void) {
        self.getArrayOf(.adminnedGames, from: .players, withId: player.id) { (adminnedGames) in
            if let adminnedGames = adminnedGames as? [Game] { completion(adminnedGames) }
        }
    }
    
    // Get teams a player is a captain of
    class func forCaptainedTeamsOf(player: Player, completion: @escaping ([Team]) -> Void) {
        self.getArrayOf(.captainedTeams, from: .players, withId: player.id) { (captainedTeams) in
            if let captainedTeams = captainedTeams as? [Team] { completion(captainedTeams) }
        }
    }
    
    //MARK: Get Info For Team
    
    // Get player for team
    class func forPlayersOn(team: Team, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, from: .teams, withId: team.id) { (players) in
            if let players = players as? [Player] { completion(players) }
        }
    }
    
    // Get captains for team
    class func forCaptainsOf(team: Team, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.captains, from: .teams, withId: team.id) { (captains) in
            if let captains = captains as? [Player] { completion(captains) }
        }
    }
    
    //MARK: Get Info for Game
    
    // Get players for game
    class func forPlayersIn(game: Game, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, from: .games, withId: game.id) { (players) in
            if let players = players as? [Player] { completion(players) }
        }
    }
    
    // Get admins for game
    class func forAdminsOf(game: Game, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.admins, from: .games, withId: game.id) { (admins) in
            if let admins = admins as? [Player] { completion(admins) }
        }
    }
    
    //MARK: Get Info by ID
    
    // Get game with ID
    class func forGameWith(id: String, completion: @escaping (Game) -> Void) {
        self.buildArrayOf(.games, for: [id], completion: {
            guard let game = $0[0] as? Game else { return }
            completion(game)
        })
    }
    
    // Get player with ID
    class func forPlayerWith(id: String, completion: @escaping (Player) -> Void) {
        self.buildArrayOf(.players, for: [id], completion: {
            guard let game = $0[0] as? Player else { return }
            completion(game)
        })
    }
    
    // Get team with ID
    class func forTeamWith(id: String, completion: @escaping (Team) -> Void) {
        self.buildArrayOf(.teams, for: [id], completion: {
            guard let game = $0[0] as? Team else { return }
            completion(game)
        })
    }
}

//MARK: Helper functions

extension QueryFirebase {
    
    fileprivate class func getArrayOf(_ category: Category, with searchField: String, of value: String, completion: @escaping ([Any]) -> Void) {
        self.getKeys(for: category.rawValue, with: searchField, of: value) { keys in
            self.buildArrayOf(category, for: keys) { completion($0) }
        }
    }
    
    // get array of games for players with ID
    fileprivate class func getArrayOf(_ category1: Category, from category2: Category, withId id: String, completion: @escaping ([Any]) -> Void) {
        print("Going to firebase for some admins")
        firebase.child(category2.rawValue).child(id).child(category1.rawValue).observeSingleEvent(of: .value, with: { snapshot in
            guard let snapshot = snapshot.value as? [String:Any] else { completion([]); return }
            let keys = Array(snapshot.keys)
            self.buildArrayOf(category1, for: keys) { completion($0) }
        })
    }
    
    //get array of players with names containing a string value
    fileprivate class func getArray(of category: Category, with searchField: String, containing value: String, completion: @escaping ([Any]) -> Void) {
        getKeysContaining(for: category.rawValue, with: searchField, of: value, completion: { keys in
            self.buildArrayOf(category, for: keys) { completion($0) }
        })
    }
    
    private class func getKeys(for root: String, with searchField: String, of lookupItem: String, completion: @escaping ([String]) -> Void ) {
        var array: [String] = []
        firebase.child(root).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String:Any] else { completion([]); return }
            snapshot.forEach {
                let item = $0.value as? [String:Any]
                guard let value = item?[searchField] as? String else { completion([]); return }
                if value == lookupItem { array.append($0.key) }
            }
            completion(array)
        })
    }
    
    fileprivate class func buildArrayOf(_ category: Category, for keys: [String], completion: @escaping ([Any]) -> Void) {
        var array = [Any]()
        for key in keys {
            firebase.child(category.type).child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                if let info = snapshot.value as? [String:Any]  {
                    switch category.type {
                    case "teams": array.append(Team(id: snapshot.key, dict: info))
                    case "games": array.append(Game(id: snapshot.key, dict: info))
                    default: array.append(Player(id: snapshot.key, dict: info))
                    }
                    if array.count == keys.count { completion(array) }
                }
            }, withCancel: { (error) in
                print("############## Error:", error)
            })
        }
    }
    
    
    private class func getKeysContaining(for root: String, with searchField: String, of lookupItem: String, completion: @escaping ([String]) -> Void ) {
        var array: [String] = []
        firebase.child(root).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String:Any] else { completion([]); return }
            snapshot.forEach {
                let item = $0.value as? [String:Any]
                guard let value = item?[searchField] as? String else { return }
                if value.lowercased().contains(lookupItem.lowercased()){ array.append($0.key) }
            }
            completion(array)
        })
    }
    
}
