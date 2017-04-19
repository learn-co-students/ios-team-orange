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
    
    static func createPlayer() {
        QueryFirebase.forPlayerWith(id: "-Kh2Wlj-Q7ICrTi_jt7R", completion: { player in
            self.player = player
        })
    }
}
