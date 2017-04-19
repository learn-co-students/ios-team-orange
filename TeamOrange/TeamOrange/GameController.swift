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
    var game: Game? {
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
    }
    
    func relayGameData() {
        guard let game = self.game else { return }
        self.myView.nameLabel.text = game.name
        self.myView.sportIcon.image = game.sport?.image.image
        self.myView.addressLabel.text = "66 Tuckerton Rd, Shamong, NJ 08088"
        self.myView.dateLabel.text = game.date
        self.myView.stateLabel.text = game.state?.rawValue
    }
}

extension GameController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let game = self.game else { return 0 }
        guard let players = game.players else { return 0 }
        return players.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell
        return cell
    }
    
}
