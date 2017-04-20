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
        self.myView.dateLabel.text = self.game.date
        self.myView.stateLabel.text = self.game.state?.rawValue
        self.myView.playersLabel.text = "Players: \(self.game.numPlayers) / \(self.game.maxPlayers)"
    }
}

extension GameController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.game else { return 0 }
        return game.maxPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell
        cell.imageView.image = indexPath.item < game.players.count ? #imageLiteral(resourceName: "runner") : #imageLiteral(resourceName: "addPlayer")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item < self.game.players.count {
            let playerController = PlayerController()
            playerController.player = self.game.players[indexPath.item]
            self.navigationController?.pushViewController(playerController, animated: true)
        } else {
            print("Add me to the game")
        }
    }
}
