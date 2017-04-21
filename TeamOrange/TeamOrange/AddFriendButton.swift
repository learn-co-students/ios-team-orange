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
    
    init(player: Player, isFriend: Bool) {
        super.init(frame: CGRect.zero)
        self.player = player
        changeImage(isFriend: isFriend)
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
        InsertToFirebase.player(withId: player.id, toPlayer: CurrentPlayer.player.id){
            let notification = Notification(name: Notification.Name(rawValue: "Added Friend"))
            NotificationCenter.default.post(notification)
        }
        
    }
    func askRemoveFriend() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AskedToRemoveFriend"), object: nil)
    }
    
    func changeImage(isFriend: Bool) {
        if isFriend{
            self.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
            self.addTarget(self, action: #selector(askRemoveFriend), for: .touchUpInside)
        }
        else {
            self.addTarget(self, action: #selector(addFriend), for: .touchUpInside)
            self.setImage(#imageLiteral(resourceName: "addPlayer"), for: .normal)
        }
    }

}
