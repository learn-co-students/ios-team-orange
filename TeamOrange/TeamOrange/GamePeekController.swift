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
        self.getGames()
        self.myView = GamePeekView()
        self.buildView()
        self.myView.layer.cornerRadius = 10
        self.myView.clipsToBounds = true
        NotificationCenter.default.addObserver(self, selector: #selector(self.animatedDismiss), name: Notification.Name("Stop Peaking"), object: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        UIView.animate(withDuration: 0.25) {
            self.view.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
        }
    }
    
    func animatedDismiss() {
        self.dismiss(animated: true, completion: nil)
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
}

extension GamePeekController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.games[collectionView.tag].maxPlayers
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell
        cell.imageView.image = indexPath.item < self.games[collectionView.tag].players.count ? #imageLiteral(resourceName: "runner") : #imageLiteral(resourceName: "addPlayer")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item < self.games[collectionView.tag].players.count {
            self.dismiss(animated: true, completion: {
                let selectedPlayer = self.games[collectionView.tag].players[indexPath.item]
                let goToPlayerNotification = Notification(name: Notification.Name("Player View With Player"), object: selectedPlayer)
                NotificationCenter.default.post(goToPlayerNotification)
                //TODO: This smells - this controller should not send up a notification that it in itself catches.  Should be solved with protocol / delegate relationship.
                let dismissNotification = Notification(name: Notification.Name("Stop Peaking"), object: nil, userInfo: nil)
                NotificationCenter.default.post(dismissNotification)
            })
        } else {
            print("Add me to the game")
        }
    }
}
