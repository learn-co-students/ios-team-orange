//
//  CurrentPlayer.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

final class CurrentPlayer {
    
    var player: Player!
    
    private init() {}
    
    func createPlayer() {
        QueryFirebase.forPlayerWith(id: "-Kh2WlizyeXGe_2Wr9NE", completion: { player in
            self.player = player
        })
    }
}
