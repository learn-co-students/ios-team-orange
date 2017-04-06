//
//  FirebaseClient.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseDatabase

class FirebaseClient {
    
    //MARK: Create Stuff
    
    class func createPlayer(with playerInfo: [String:Any] ) {
        FIRDatabase.database().reference().child("players").childByAutoId().setValue(playerInfo)
    }
    
    class func createGame(with gameInfo: [String:Any]) {
        FIRDatabase.database().reference().child("games").childByAutoId().setValue(gameInfo)
    }
    
    class func createTeam(with teamInfo: [String:Any]) {
        FIRDatabase.database().reference().child("teams").childByAutoId().setValue(teamInfo)
    }
    
    //MARK: Get Users with Info
    
    // Find user by displayName
    class func getUsersWith(displayName: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.users, with: "name", of: displayName) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find user by email
    class func getUsersWith(email: String, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.users, with: "email", of: email) { (users) in
            if let users = users as? [Player] { completion(users) }
        }
    }
    
    // Find user by phone
    class func getUsersWith(phone: Int, completion: @escaping ([Player]) -> Void) {
        self.getArrayOf(.users, with: "phone", of: String(phone)) { (users) in
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
    
    // Add team to player & player to team
    // Add game to player & player to game
    // Add player1 to player2 Friends & player2 to player1 Friends
    
    
    
    
    
    //MARK: Get Info For Team
    
    class func getUsersFor(teamId: String) -> Player {
        return Player(id: "", dict: [:]) //temporary
    }
    
    class func getCaptainFor(teamId: String) -> Player {
        return Player(id: "", dict: [:]) //temporary
    }
    
    class func getCoCaptainsFor(teamId: String) -> [Player]{
        return [Player]() //temporary
    }
    
    //MARK: Get Info For User
    
    
    class func getGamesFor(userId: String) -> [Game] {
        return [Game]() //temporary
    }
    
    class func getTeamsFor(userId: String) -> [Team] {
        return [Team]() //temporary
    }
    
    class func getFriendsFor(userId: String) -> [Player] {
        return [Player]() //temporary
    }
    
    
    //MARK: Get Info for Game
    
    
    class func getUsersFor(gameId: String) -> [Player] {
        return [Player]() //temporary
    }
    
    class func getAdminFor(gameId: String) -> Player {
        return Player(id: "", dict: [:]) //temporary
    }
}

extension FirebaseClient {
    
    fileprivate class func getArrayOf(_ category: Category,with searchField: String,of value: String, completion: @escaping ([Any]) -> Void) {
        var dict = [Any]()
        self.getKeyValuePairs(root: category.rawValue, searchField: searchField, lookupItem: value) { pairs in
            for pair in pairs {
                FIRDatabase.database().reference().child(category.rawValue).child(pair.key).observeSingleEvent(of: .value, with: { snapshot in
                    let id = snapshot.key
                    if let info = snapshot.value as? [String:Any] {
                        switch category {
                        case .users: dict.append(Player(id: id, dict: info))
                        case .teams: dict.append(Team(id: id, dict: info))
                        case .games: dict.append(Game(id: id, dict: info))
                        }
                        if dict.count == pairs.count {
                            completion(dict)
                        }
                    }
                })
            }
        }
    }
    
    private class func getKeyValuePairs(root: String, searchField: String, lookupItem: String, completion: @escaping ([String:String]) -> Void ) {
        var dict: [String:String] = [:]
        FIRDatabase.database().reference().child(root).observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.value as? [String:Any] else { return }
            snapshot.forEach {
                let key = $0.key
                let array = $0.value as? [String:Any]
                guard let value = array?[searchField] as? String else { return }
                if value == lookupItem { dict.updateValue(value, forKey: key) }
            }
            completion(dict)
        })
    }
}

