//
//  JoinGameAlert.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/23/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

enum JoinGameAlert {
    case canJoin, canLeave, doNothing

    static func get (forVc vc: GameController, state: JoinGameAlert) -> UIAlertController {
        switch state {
        case .canJoin:
            let myAlert = UIAlertController(title: "Do you want to join this game?", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Do it", style: .default, handler: {_ in
                InsertToFirebase.player(withId: CurrentPlayer.player.id, toGame: vc.game.id, completion: {
                    vc.present(JoinGameAlert.canJoin.confirmation, animated: true, completion: nil)
                })
            })
            let cancelAction = UIAlertAction(title: "Forget it", style: .cancel, handler: nil)
            myAlert.addAction(okAction)
            myAlert.addAction(cancelAction)
            return myAlert
        case .canLeave:
            let myAlert = UIAlertController(title: "Do you want to  this game?", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Do it", style: .destructive, handler: {_ in
                RemoveFromFirebase.player(from: vc.game.id, withId: CurrentPlayer.player.id, completion: {
                    vc.present(JoinGameAlert.canLeave.confirmation, animated: true, completion: {
                        RemoveFromFirebase.admin(from: vc.game.id, withId: CurrentPlayer.player.id, completion: {})
                    })
                })
            })
            let cancelAction = UIAlertAction(title: "Forget it", style: .cancel, handler: nil)
            myAlert.addAction(okAction)
            myAlert.addAction(cancelAction)
            return myAlert
        case .doNothing:
            return JoinGameAlert.doNothing.confirmation
        }
    }
    
    private var confirmation: UIAlertController {
        switch self {
        case .canJoin:
            let myAlert = UIAlertController(title: "You've joined the game.", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            return myAlert
        case .canLeave:
            let myAlert = UIAlertController(title: "You've left the game.", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            return myAlert
        case .doNothing:
            let myAlert = UIAlertController(title: "This game can't be joined.", message: nil, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
            myAlert.addAction(okAction)
            return myAlert
            
        }
    }
}
