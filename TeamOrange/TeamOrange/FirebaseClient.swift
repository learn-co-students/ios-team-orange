//
//  FirebaseClient.swift
//  TeamOrange
//
//  Created by William Brancato on 4/3/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

class FirebaseClient {
    
    
    //MARK: Teams
    
    class func getUserFor(teamId: String) -> User {
        
    }
    
    class func getCapatainFor(teamId: String) -> User {
        
    }
    
    class func getCoCaptainsFor(teamId: String) -> [User]{
        
    }
    
    //MARK: Users
    
    class func getGamesFor(userId: String) -> [Game] {
        
    }
    
    class func getTeamsFor(userId: String) -> [Team] {
        
    }
    
    class func getFavLocationsFor(userId: String) -> [Location] {
        
    }
    
    class func getFriendsFor(userId: String) -> [User] {
        
    }
    
    //MARK: Games
    
    class func getUsersFor(gameId: String) -> [User] {
        
    }
    
    class func getLocationFor(gameId: String) -> Location {
        
    }
    
    class func getAdminFor(gameId: String) -> User {
        
    }
    
    //MARK: Locations
    
    class func getGamesFor(locationId: String) -> [Game] {
        
    }
    
    class func getUsersFor(locationId: String) -> [User] {
        
    }
    
}
