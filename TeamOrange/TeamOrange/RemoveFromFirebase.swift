//
//  RemoveFromFirebase.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/20/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import FirebaseDatabase

class RemoveFromFirebase {
    
    private static let firebase = FIRDatabase.database().reference()
    
    class func friend (of player: String, withId friend: String, completion: @escaping ()->()) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        firebase.child("players").child(player).child("friends").child(friend).removeValue(completionBlock: { _ in
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        firebase.child("players").child(friend).child("friends").child(player).removeValue(completionBlock: { _ in
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
    class func player (from game: Game, withId id: String, completion: @escaping (Bool)->()) {
        var isAdmin = false
        QueryFirebase.forAdminsOf(game: game , completion: { players in
            isAdmin = players.contains(where: {$0.id == id})
            if isAdmin {
                completion(false)
            } else {
                let dispatchGroup = DispatchGroup()
                dispatchGroup.enter()
                firebase.child("games").child(game.id).child("players").child(id).removeValue(completionBlock: { _ in
                    dispatchGroup.leave()
                })
                dispatchGroup.enter()
                firebase.child("players").child(id).child("games").child(game.id).removeValue(completionBlock: { _ in
                    dispatchGroup.leave()
                })
                dispatchGroup.notify(queue: DispatchQueue.main) {
                    completion(true)
                }
            }
        })
    }
    
    class func admin (from game: String, withId id: String, completion: @escaping ()->()) {
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        firebase.child("games").child(game).child("admins").child(id).removeValue(completionBlock: { _ in
            dispatchGroup.leave()
        })
        dispatchGroup.enter()
        firebase.child("players").child(id).child("adminOf").child(game).removeValue(completionBlock: { _ in
            dispatchGroup.leave()
        })
        dispatchGroup.notify(queue: DispatchQueue.main) {
            completion()
        }
    }
    
}
