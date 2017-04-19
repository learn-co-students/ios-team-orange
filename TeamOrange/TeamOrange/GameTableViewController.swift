//
//  GameTableViewController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/18/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GameTableViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero)
    var player: Player? {
        didSet {
            guard let player = self.player else { return }
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.buildStaticNavBar()
        self.addAndConstrain(view: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.register(GameTableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension GameTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let player = self.player else { return 0 }
        return player.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        if let player = self.player {
            cell.game = player.games[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let gameController = GameController()
        gameController.game = self.player?.games[indexPath.row]
        self.navigationController?.pushViewController(gameController, animated: true)
    }
}

