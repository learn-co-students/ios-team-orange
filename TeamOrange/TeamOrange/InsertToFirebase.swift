//
//  FirebaseClient.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import FirebaseDatabase

//TODO:  Need to add error response notifications for pretty much every one of these functions.
final class InsertToFirebase {
    
    private init() { }
    
    //MARK: Create new model in database
    
    class func newPlayer(with playerInfo: [String:Any], completion: (String) -> Void ) {
        //FIRDatabase.database().reference().child("players").childByAutoId().setValue(playerInfo)
        let post = FIRDatabase.database().reference().child("players").childByAutoId()
        post.setValue(playerInfo)
        completion(post.key)
    }
    
    class func newGame(with gameInfo: [String:Any], completion: (String) -> Void) {
        let post = FIRDatabase.database().reference().child("games").childByAutoId()
        post.setValue(gameInfo)
        completion(post.key)
    }
    
    class func newTeam(with teamInfo: [String:Any], completion: (String) -> Void) {
        let post = FIRDatabase.database().reference().child("teams").childByAutoId()
        post.setValue(teamInfo)
        completion(post.key)
    }
    
    //MARK: Add players to other models
    
    // Add team to player & player to team
    class func player(withId playerId: String, toTeam teamId: String, completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        FIRDatabase.database().reference().child("players").child(playerId).child("teams").child(teamId).setValue(true, withCompletionBlock: { (error, FIRDataReference) in
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        FIRDatabase.database().reference().child("teams").child(teamId).child("players").child(playerId).setValue(true, withCompletionBlock: { (error, FIRDataReference) in
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    // Add game to player & player to game
    class func player(withId playerId: String, toGame gameId: String, completion: @escaping () -> Void) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        FIRDatabase.database().reference().child("players").child(playerId).child("games").child(gameId).setValue(true, withCompletionBlock: { (error, FIRDatabaseReference) in
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        FIRDatabase.database().reference().child("games").child(gameId).child("players").child(playerId).setValue(true, withCompletionBlock: { (error, FIRDatabaseReference) in
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    // Add player1 to player2 Friends & player2 to player1 Friends
    class func player(withId player1Id: String, toPlayer player2Id: String) {
        FIRDatabase.database().reference().child("players").child(player1Id).child("friends").child(player2Id).setValue(true)
        FIRDatabase.database().reference().child("players").child(player2Id).child("friends").child(player1Id).setValue(true)
    }
    
    // Add captain (player) to team and team to captain (player)
    class func captain(withId playerId: String, toTeam teamId: String) {
        FIRDatabase.database().reference().child("players").child(playerId).child("captainOf").child(teamId).setValue(true)
        FIRDatabase.database().reference().child("teams").child(teamId).child("captains").child(playerId).setValue(true)
    }
    
    // Add admin (player) to game and game to admin (player)
    class func admin(withId playerId: String, toGame gameId: String) {
        FIRDatabase.database().reference().child("players").child(playerId).child("adminOf").child(gameId).setValue(true)
        FIRDatabase.database().reference().child("games").child(gameId).child("admins").child(playerId).setValue(true)
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

