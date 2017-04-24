//
//  GameView.swift
//  TeamOrange
//
//  Created by William Brancato on 4/18/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GameController: UIViewController {
    
    let myView = GameView()
    var isInGame = false
    var hasStarted = true
    var isFull = true
    var isAdmin = false
    var alert = UIAlertController(title: "buttonTapped", message: nil, preferredStyle: .alert)
    var dateString: String!
    
    var game: Game! {
        didSet {
            self.relayGameData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.buildStaticNavBar()
        self.myView.collectionView.delegate = self
        self.myView.collectionView.dataSource = self
        self.addAndConstrain(view: self.myView)
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func relayGameData() {
        self.myView.nameLabel.text = self.game.name
        self.myView.sportIcon.image = self.game.sport?.image.image
        self.myView.addressLabel.text = "66 Tuckerton Rd, Shamong, NJ 08088"
        self.myView.dateLabel.text = self.game.dateString
        self.myView.stateLabel.text = self.game.state?.rawValue
        self.myView.playersLabel.text = "Players: \(self.game.numPlayers) / \(self.game.maxPlayers)"
    }
    
    func addPlayerToGame(game: Game) {
        InsertToFirebase.player(withId: CurrentPlayer.player.id, toGame: self.game.id, completion: {
            self.game.fillArrays {
                self.myView.collectionView.reloadData()
            }
        })
    }
    
    func goToPlayer(player: Player) {
        let playerController = PlayerController()
        playerController.player = player
        self.navigationController?.pushViewController(playerController, animated: true)
    }
    
    func presentInGameAlert() {
        let alert = UIAlertController(title: "Already playing in this game!", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Got It", style: .destructive, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
}



extension GameController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.game else { return 0 }
        return game.maxPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell
        let isGamePlayer = indexPath.item < self.game.players.count
        let isCurrentPlayer = isGamePlayer && self.game.players[indexPath.row].id == CurrentPlayer.player.id
        if isCurrentPlayer { cell.backgroundColor = UIColor.yellow }
        cell.imageView.image = indexPath.item < game.players.count ? #imageLiteral(resourceName: "runner") : #imageLiteral(resourceName: "addPlayer")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < self.game.players.count {
            let selectedPlayer = self.game.players[indexPath.item]
            self.goToPlayer(player: selectedPlayer)
        } else if self.game.containsPlayer(withId: CurrentPlayer.player.id) {
            self.presentInGameAlert()
        } else {
            self.addPlayerToGame(game: self.game)
        }
    }
}
