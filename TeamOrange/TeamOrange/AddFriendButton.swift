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
        changeImage()
        self.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
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
    
    var isFriend: Bool {
        return CurrentPlayer.player.friends.contains(where: {player.id == $0.id})
    }
    
    func buttonAction() {
        if isFriend {
            askRemoveFriend()
        } else {
            addFriend()
        }
    }
    
    func addFriend() {
        InsertToFirebase.player(withId: player.id, toPlayer: CurrentPlayer.player.id){
            let notification = Notification(name: Notification.Name(rawValue: "Added Friend"))
            NotificationCenter.default.post(notification)
        }
        
    }
    func askRemoveFriend() {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "AskedToRemoveFriend"), object: nil)
    }
    
    func changeImage() {
        print ("is friend \(isFriend)")
        if isFriend{
            self.setImage(#imageLiteral(resourceName: "facebook"), for: .normal)
        }
        else {
            self.setImage(#imageLiteral(resourceName: "addPlayer"), for: .normal)
        }
    }

}
