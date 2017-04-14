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
            if self.games.count == self.location.games.count {
                self.myView.gamePeekScroller.gamePeekDelegate = self
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getGames(completion: {
            
        })
        self.myView = GamePeekView()
        self.buildView()
        self.myView.layer.cornerRadius = 10
        self.myView.clipsToBounds = true
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
    
    func getGames(completion: @escaping () -> Void) {
        self.location.games.forEach {
            QueryFirebase.forGameWith(id: $0, completion: {
                self.games.append($0)
                if self.location.games.count == self.games.count {
                    completion()
                }
            })
        }
    }
}

extension GamePeekController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "playerCell", for: indexPath) as! PlayerCollectionViewCell
        return cell
    }
}
