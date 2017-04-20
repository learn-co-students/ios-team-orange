//
//  GamepeekController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/11/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GamePeekController: UIViewController, GamePeekScrollerDelegate {
    
    var myView: GamePeekView!
    let gestureView = UIView()
    var location: Location!
    var games: [Game] = [] {
        didSet {
            let isLastGame = self.games.count == self.location.games.count
            if isLastGame {
                self.myView.gamePeekScroller.gamePeekDelegate = self
                self.myView.gamePeekScroller.setupStack()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildGestureView()
        self.getGames()
        self.myView = GamePeekView()
        self.buildView()
        self.myView.layer.cornerRadius = 10
        self.myView.clipsToBounds = true
        self.navigationController?.navigationBar.isHidden = false
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25) {
            self.view.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }
    }
    
    func buildView() {
        self.view.addSubview(self.myView)
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.myView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.5).isActive = true
        self.myView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func getGames() {
        self.location.games.forEach {
            QueryFirebase.forGameWith(id: $0, completion: { game in
                game.fillArrays {
                    self.games.append(game)
                }
            })
        }
    }
    
    func goToPlayer(player: Player) {
        self.dismiss(animated: true, completion: {
            
            let goToPlayerNotification = Notification(name: Notification.Name("Player View With Player"), object: player)
            NotificationCenter.default.post(goToPlayerNotification)
            //TODO: This smells - this controller should not send up a notification that it in itself catches.  Should be solved with protocol / delegate relationship.
            let dismissNotification = Notification(name: Notification.Name("Stop Peeking"), object: nil, userInfo: nil)
            NotificationCenter.default.post(dismissNotification)
        })
    }
    
    func presentInGameAlert() {
        let alert = UIAlertController(title: "Already playing in this game!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Got It", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func addPlayerToGame(game: Game, collectionViewTag: Int) {
        InsertToFirebase.player(withId: CurrentPlayer.player.id, toGame: game.id, completion: {
            if let abbreviatedGameView = self.myView.gamePeekScroller.gameStack.viewWithTag(collectionViewTag + 100) as? AbbreviatedGameView {
                abbreviatedGameView.game.fillArrays {
                    abbreviatedGameView.collectionView.reloadData()
                    abbreviatedGameView.setPlayersLabelText()
                }
            }
        })
    }
    
    //TODO: This should really reside in the peakview
    func buildGestureView() {
        self.gestureView.addAndConstrainToEdges(of: self.view)
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.dismissScreen))
        self.gestureView.addGestureRecognizer(gestureRecognizer)
    }
    
    func dismissScreen() {
        self.dismiss(animated: true, completion: nil)
        let notification = Notification(name: Notification.Name("Stop Peeking"), object: nil, userInfo: nil)
        NotificationCenter.default.post(notification)
    }
}

extension GamePeekController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games[collectionView.tag].maxPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell
        let isGamePlayer = indexPath.item < self.games[collectionView.tag].players.count
        let isCurrentPlayer = isGamePlayer && self.games[collectionView.tag].players[indexPath.row].id == CurrentPlayer.player.id
        cell.imageView.image = isGamePlayer ? #imageLiteral(resourceName: "runner") : #imageLiteral(resourceName: "addPlayer")
        if isCurrentPlayer { cell.backgroundColor = UIColor.white }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < self.games[collectionView.tag].players.count {
            let selectedPlayer = self.games[collectionView.tag].players[indexPath.item]
            self.goToPlayer(player: selectedPlayer)
        } else if self.games[collectionView.tag].containsPlayer(withId: CurrentPlayer.player.id) {
            self.presentInGameAlert()
        } else {
            let game = self.games[collectionView.tag]
            self.addPlayerToGame(game: game, collectionViewTag: collectionView.tag)
        }
    }
}
