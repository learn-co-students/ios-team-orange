//
//  JoinGameAlert.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/23/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

enum JoinGameAlert {
    case canJoin, canLeave, cantLeave, doNothing
    
    private static let cancelAction = UIAlertAction(title: "Forget it", style: .cancel, handler: nil)
    private static let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
    
    static func get (forVc vc: GameController, state: JoinGameAlert) -> UIAlertController {
        switch state {
        case .canJoin:
            let myAlert = UIAlertController(title: "Do you want to join this game?", message: nil, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Do it", style: .default, handler: {_ in
                InsertToFirebase.player(withId: CurrentPlayer.player.id, toGame: vc.game.id, completion: {
                    CurrentPlayer.player.fillArrays {
                        vc.getGameStatus()
                        vc.present(JoinGameAlert.canJoin.confirmation, animated: true, completion: nil)
                    }
                })
            })
            myAlert.addAction(confirmAction)
            myAlert.addAction(cancelAction)
            return myAlert
        case .canLeave:
            let myAlert = UIAlertController(title: "Do you want to leave this game?", message: nil, preferredStyle: .alert)
            let confirmAction = UIAlertAction(title: "Do it", style: .destructive, handler: { _ in
                RemoveFromFirebase.player(from: vc.game, withId: CurrentPlayer.player.id, completion: { success in
                    if success{
                        CurrentPlayer.player.fillArrays {
                            vc.getGameStatus()
                            vc.present(JoinGameAlert.canLeave.confirmation, animated: true, completion: {})
                        }
                    } else {
                        vc.present(JoinGameAlert.get(forVc: vc, state: .cantLeave), animated: true)
                    }
                })
            })
            myAlert.addAction(confirmAction)
            myAlert.addAction(cancelAction)
            return myAlert
        case .cantLeave:
            let myAlert = UIAlertController(title: "If you leave, the game will be cancelled. Is this OK?", message: nil, preferredStyle: .alert)
            let leaveAction = UIAlertAction(title: "Leave", style: .destructive, handler: {_ in
                InsertToFirebase.newState(of: .cancelled, forGame: vc.game.id)
            })
            myAlert.addAction(leaveAction)
            myAlert.addAction(okAction)
            return myAlert
        case .doNothing:
            return JoinGameAlert.doNothing.confirmation
        }
    }
    
    private var confirmation: UIAlertController {
        switch self {
        case .canJoin:
            let myAlert = UIAlertController(title: "You've joined the game.", message: nil, preferredStyle: .alert)
            myAlert.addAction(JoinGameAlert.okAction)
            return myAlert
        case .canLeave:
            let myAlert = UIAlertController(title: "You've left the game.", message: nil, preferredStyle: .alert)
            myAlert.addAction(JoinGameAlert.okAction)
            return myAlert
        case .cantLeave:
            let myAlert = UIAlertController(title: "You've cancelled the game", message: nil, preferredStyle: .alert)
            myAlert.addAction(JoinGameAlert.okAction)
            return myAlert
        case .doNothing:
            let myAlert = UIAlertController(title: "This game can't be joined.", message: nil, preferredStyle: .alert)
            myAlert.addAction(JoinGameAlert.okAction)
            return myAlert
            
        }
    }
}
