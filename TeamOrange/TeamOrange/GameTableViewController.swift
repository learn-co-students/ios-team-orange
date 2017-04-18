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
    var games: [Game] = []
    var player: Player? {
        didSet {
            guard let player = self.player else { return }
            self.games = player.games
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
    }
}

extension GameTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! GameTableViewCell
        if let player = self.player {
            cell.game = self.games[indexPath.row]
        }
        return cell
    }
}

