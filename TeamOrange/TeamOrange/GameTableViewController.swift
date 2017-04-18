//
//  GameTableViewController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/18/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GameTableViewController: UITableViewController {
    
    var games: [Game] = []
    var player: Player? {
        didSet {
            guard let player = self.player else { return }
            guard let games = player.games else { return }
            self.games = games
            self.tableView.reloadData()
        }
    }
    
    init() {
        super.init(style: .plain)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(GameTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension GameTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        if let player = self.player {
            cell.game = self.games[indexPath.row]
        }
        return cell
    }
}

