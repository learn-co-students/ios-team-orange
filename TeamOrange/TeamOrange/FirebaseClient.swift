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
  
/*
    //MARK: Get Info For Team

    class func getUserFor(teamId: String) -> User {
        
    }
    
    class func getCapatainFor(teamId: String) -> User {
        
    }
    
    class func getCoCaptainsFor(teamId: String) -> [User]{
        
    }

    //MARK: Get Info For User

    
    class func getGamesFor(userId: String) -> [Game] {
        
    }
    
    class func getTeamsFor(userId: String) -> [Team] {
        
    }
    
    class func getFavLocationsFor(userId: String) -> [Location] {
        
    }
    
    class func getFriendsFor(userId: String) -> [User] {
        
    }
    

    //MARK: Get Info For Game

    
    class func getUsersFor(gameId: String) -> [User] {
        
    }
    
    class func getLocationFor(gameId: String) -> Location {
        
    }
    
    class func getAdminFor(gameId: String) -> User {
        
    }
    
    //MARK: Get Info For Location

    
    class func getGamesFor(locationId: String) -> [Game] {
        
    }
    
    class func getUsersFor(locationId: String) -> [User] {
        
    }
*/
}
