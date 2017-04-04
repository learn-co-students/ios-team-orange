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
    
    func createUser(with userInfo: [String:Any] ) {
        FIRDatabase.database().reference().child("users").childByAutoId().setValue(userInfo)
    }
    
    func createGame() {
        
    }
    
    func createTeam() {
        
    }
    
    func createLocation() {
        
    }
  

    //MARK: Get Info For Team

    class func getUserFor(teamId: String) -> User {
        return User(userDict: [:])! //temporary
    }
    
    class func getCaptainFor(teamId: String) -> User {
        return User(userDict: [:])! //temporary
    }
    
    class func getCoCaptainsFor(teamId: String) -> [User]{
        return [User]() //temporary
    }

    //MARK: Get Info For User

    
    class func getGamesFor(userId: String) -> [Game] {
        return [Game]() //temporary
    }
    
    class func getTeamsFor(userId: String) -> [Team] {
        return [Team]() //temporary
    }
    
    class func getFavLocationsFor(userId: String) -> [Location] {
        return [Location]() //temporary
    }
    
    class func getFriendsFor(userId: String) -> [User] {
        return [User]() //temporary
    }
    

    //MARK: Get Info For Game

    
    class func getUsersFor(gameId: String) -> [User] {
        return [User]() //temporary
    }
    
    class func getLocationFor(gameId: String) -> Location {
        return Location(id: "", dict: [:])! // temporary
    }
    
    class func getAdminFor(gameId: String) -> User {
        return User(userDict: [:])! //temporary
    }
    
    //MARK: Get Info For Location

    
    class func getGamesFor(locationId: String) -> [Game] {
        return [Game]() //temporary
    }
    
    class func getUsersFor(locationId: String) -> [User] {
        return [User]() //temporary
    }

}
