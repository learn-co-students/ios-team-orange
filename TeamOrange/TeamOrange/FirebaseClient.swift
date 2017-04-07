//
//  FirebaseClient.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import FirebaseDatabase

class FirebaseClient {
    
//MARK: Create new model in database
    
    class func createPlayer(with playerInfo: [String:Any] ) {
        FIRDatabase.database().reference().child("players").childByAutoId().setValue(playerInfo)
    }
    
    class func createGame(with gameInfo: [String:Any]) {
        FIRDatabase.database().reference().child("games").childByAutoId().setValue(gameInfo)
    }
    
    class func createTeam(with teamInfo: [String:Any]) {
        FIRDatabase.database().reference().child("teams").childByAutoId().setValue(teamInfo)
    }
    
//MARK: Look up model with information
    
    // Find user by displayName
    class func getPlayersWith(name: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, with: "name", of: name) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find user by email
    class func getPlayersWith(email: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, with: "email", of: email) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find user by phone
    class func getPlayersWith(phone: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, with: "phone", of: String(phone)) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find game by game name
    class func getGamesWith(name: String, completion: @escaping ([Game]) -> Void) {
        self.getArrayOf(.games, with: "name", of: name) { (games) in
            if let games = games as? [Game] { completion(games) }
        }
    }
    
    // Find team by team name
    class func getTeamsWith(name: String, completion: @escaping ([Team]) -> Void) {
        self.getArrayOf(.teams, with: "name", of: name) { (teams) in
            if let teams = teams as? [Team] { completion(teams) }
        }
    }
    
//MARK: Add players to other models
    
    // Add team to player & player to team
    class func addPlayer(withId playerId: String, toTeam teamId: String) {
        FIRDatabase.database().reference().child("players").child(playerId).child("teams").child(teamId).setValue(true)
        FIRDatabase.database().reference().child("teams").child(teamId).child("players").child(playerId).setValue(true)
    }
    
    
    // Add game to player & player to game
    class func addPlayer(withId playerId: String, toGame gameId: String) {
        FIRDatabase.database().reference().child("players").child(playerId).child("games").child(gameId).setValue(true)
        FIRDatabase.database().reference().child("games").child(gameId).child("players").child(playerId).setValue(true)
    }
    
    // Add player1 to player2 Friends & player2 to player1 Friends
    class func addPlayer(withId player1Id: String, toPlayer player2Id: String) {
        FIRDatabase.database().reference().child("players").child(player1Id).child("friends").child(player2Id).setValue(true)
        FIRDatabase.database().reference().child("players").child(player2Id).child("friends").child(player1Id).setValue(true)
    }
    
    // Add captain (player) to team and team to captain (player)
    class func addCaptain(withId playerId: String, toTeam teamId: String) {
        FIRDatabase.database().reference().child("players").child(playerId).child("captainOf").child(teamId).setValue(true)
        FIRDatabase.database().reference().child("teams").child(teamId).child("captains").child(playerId).setValue(true)
    }
    
    // Add admin (player) to game and game to admin (player)
    class func addAdmin(withId playerId: String, toGame gameId: String) {
        FIRDatabase.database().reference().child("players").child(playerId).child("adminOf").child(gameId).setValue(true)
        FIRDatabase.database().reference().child("games").child(gameId).child("admins").child(playerId).setValue(true)
    }

    
//MARK: Get Info For Player
    
    // Get games for player
    class func getGamesFor(playerId: String, completion: @escaping ([Game]) -> Void) {
        self.getArrayOf(.games, from: .players, withId: playerId) { (games) in
            if let games = games as? [Game] { completion(games) }
        }
    }
    
    // Get teams for player
    class func getTeamsFor(playerId: String, completion: @escaping ([Team]) -> Void) {
        self.getArrayOf(.teams, from: .players, withId: playerId) { (teams) in
            if let teams = teams as? [Team] { completion(teams) }
        }
    }

    // Get friends for player
    class func getFriendsFor(playerId: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.friends, from: .players, withId: playerId) { (friends) in
            if let friends = friends as? [Player] { completion(friends) }
        }
    }
    
    // Get games a player is an admin of
    class func getAdminnedGamesFor(playerId: String, completion: @escaping ([Game]) -> Void) {
        self.getArrayOf(.adminnedGames, from: .players, withId: playerId) { (adminnedGames) in
            if let adminnedGames = adminnedGames as? [Game] { completion(adminnedGames) }
        }
    }
    
    // Get teams a player is a captain of
    class func getCaptainedTeamsFor(playerId: String, completion: @escaping ([Team]) -> Void) {
        self.getArrayOf(.captainedTeams, from: .players, withId: playerId) { (captainnedTeams) in
            if let captainnedTeams = captainnedTeams as? [Team] { completion(captainnedTeams) }
        }
    }
    
//MARK: Get Info For Team
    
    // Get player for team
    class func getPlayersFor(teamId: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, from: .teams, withId: teamId) { (players) in
            if let players = players as? [Player] { completion(players) }
        }
    }
    
    // Get captains for team
    class func getCaptainsFor(teamId: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.captains, from: .teams, withId: teamId) { (captains) in
            if let captains = captains as? [Player] { completion(captains) }
        }
    }
    
//MARK: Get Info for Game
    
    // Get players for game
    class func getPlayersFor(gameId: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.players, from: .games, withId: gameId) { (players) in
            if let players = players as? [Player] { completion(players) }
        }
    }
    
    // Get admins for game
    class func getAdminsFor(gameId: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.admins, from: .games, withId: gameId) { (admins) in
            if let admins = admins as? [Player] { completion(admins) }
        }
    }
}


extension FirebaseClient {

//MARK: Helper functions
    
    fileprivate class func getArrayOf(_ category: Category, with searchField: String, of value: String, completion: @escaping ([Any]) -> Void) {
        self.getKeys(for: category.rawValue, with: searchField, of: value) { keys in
            self.buildArrayOf(category, for: keys) { completion($0) }
        }
    }
    
    // get array of games for players with ID
    fileprivate class func getArrayOf(_ category1: Category, from category2: Category, withId id: String, completion: @escaping ([Any]) -> Void) {
        FIRDatabase.database().reference().child(category2.rawValue).child(id).child(category1.rawValue).observeSingleEvent(of: .value, with: { snapshot in
            guard let snapshot = snapshot.value as? [String:Any] else { return }
            let keys = Array(snapshot.keys)
            self.buildArrayOf(category1, for: keys) { completion($0) }
        })
    }
    
    private class func getKeys(for root: String, with searchField: String, of lookupItem: String, completion: @escaping ([String]) -> Void ) {
        var array: [String] = []
        FIRDatabase.database().reference().child(root).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String:Any] else { return }
            snapshot.forEach {
                let item = $0.value as? [String:Any]
                guard let value = item?[searchField] as? String else { return }
                if value == lookupItem { array.append($0.key) }
            }
            completion(array)
        })
    }
    
    private class func buildArrayOf(_ category: Category, for keys: [String], completion: @escaping ([Any]) -> Void) {
        var array = [Any]()
        for key in keys {
            FIRDatabase.database().reference().child(category.type).child(key).observeSingleEvent(of: .value, with: { snapshot in
                if let info = snapshot.value as? [String:Any] {
                    switch category.type {
                    case "teams": array.append(Team(id: snapshot.key, dict: info))
                    case "games": array.append(Game(id: snapshot.key, dict: info))
                    default: array.append(Player(id: snapshot.key, dict: info))
                    }
                    if array.count == keys.count { completion(array) }
                }
            })
        }
    }
}

/*
extension FirebaseClient {
    
    class func fillDatabase() {
        for num in 0...9 {
            let playerInfo : [String:Any] = [
                "birthDate" : "9/\(num)/1986",
                "favSport" : "Baseball",
                "gender" : "male",
                "homeField" : "Dingletown",
                "homeTown" : "Medford",
                "imageUrlString" : "www.url.com",
                "name" : "username\(num)",
                "zipCode" : "33021",
                "phone" : "609313209\(num)",
                "email" : "myEmail\(num)@gmail.com"
            ]
            
            FirebaseClient.createPlayer(with: playerInfo)
            
            let teamInfo : [String:Any] = [
                "color" : "blue",
                "homeField" : "Shea Stadium",
                "imageUrlString" : "www.url.com",
                "name" : "NYC All Stars \(num)"
            ]
            
            FirebaseClient.createTeam(with: teamInfo)
            
            let gameInfo: [String:Any] = [
                "date" : "9/\(num)/2017",
                "name" : "Game \(num)",
                "over" : true,
                "success" : false,
                "sport" : "Baseball",
                "state" : "Not Started"
            ]
            
            FirebaseClient.createGame(with: gameInfo)
        }
        
        var playerKeys: [String] = []
        var teamKeys: [String] = []
        var gameKeys: [String] = []
        FIRDatabase.database().reference().child("players").observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.value as? [String:Any]
            for snap in snapshot! {
                playerKeys.append(snap.key)
            }
            FIRDatabase.database().reference().child("teams").observeSingleEvent(of: .value, with: { snapshot in
                let snapshot = snapshot.value as? [String:Any]
                for snap in snapshot! {
                    teamKeys.append(snap.key)
                }
                FIRDatabase.database().reference().child("games").observeSingleEvent(of: .value, with: { snapshot in
                    let snapshot = snapshot.value as? [String:Any]
                    for snap in snapshot! {
                        gameKeys.append(snap.key)
                    }
                    for playerKey in playerKeys {
                        
                        let randomNumber1 = arc4random_uniform(9) + 1
                        for _ in 0...randomNumber1 {
                            FirebaseClient.addPlayer(withId: playerKey, toGame: gameKeys[Int(arc4random_uniform(10))])
                        }
                        
                        let randomNumber2 = arc4random_uniform(9) + 1
                        for _ in 0...randomNumber2 {
                            FirebaseClient.addPlayer(withId: playerKey, toTeam: teamKeys[Int(arc4random_uniform(10))])
                        }
                        
                        let randomNumber3 = arc4random_uniform(9) + 1
                        for _ in 0...randomNumber3 {
                            FirebaseClient.addPlayer(withId: playerKey, toPlayer: playerKeys[Int(arc4random_uniform(10))])
                        }
                    }
                    
                    for teamKey in teamKeys {
                        let randomNumber = arc4random_uniform(3) + 1
                        for _ in 0...randomNumber {
                            FirebaseClient.addCaptain(withId: playerKeys[Int(arc4random_uniform(10))], toTeam: teamKey)
                        }
                    }
                    
                    for gameKey in gameKeys {
                        let randomNumber = arc4random_uniform(3) + 1
                        for _ in 0...randomNumber {
                            FirebaseClient.addAdmin(withId: playerKeys[Int(arc4random_uniform(10))], toGame: gameKey)
                        }
                    }
                    
                })
            })
        })
        
    }
}
*/

