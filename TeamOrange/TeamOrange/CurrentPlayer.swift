//
//  CurrentPlayer.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

final class CurrentPlayer {
    
    static private(set) var player: Player!
    
    private init() {}
    
    static func createPlayer( completion: ()->() ) {
        QueryFirebase.forPlayerWith(id: "-KiAkuDUeo9pyuE-bBcl", completion: { player in
            self.player = player
            print("############# player:", player)
        })
    }
}
