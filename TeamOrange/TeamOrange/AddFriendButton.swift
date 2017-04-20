//
//  AddFriendButton.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/20/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class AddFriendButton: UIButton {
    
    weak var player: Player!
    
    init(player: Player) {
        super.init(frame: CGRect.zero)
        self.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
        self.player = player
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    func addFriend() {
        InsertToFirebase.player(withId: player.id, toPlayer: CurrentPlayer.player.id)
        let completion = {
            let alert = UIAlertController(title: "Friend Added!", message: "\(self.player.name ?? "ERROR") added to friends", preferredStyle: .alert)
        }
        
    }

}
