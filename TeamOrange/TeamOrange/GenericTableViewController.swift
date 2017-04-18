//
//  GenericTableViewController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class GenericTableViewController: UITableViewController {
    
    var friends: [Player] = []
    var player: Player? {
        didSet {
            guard let player = self.player else { return }
            guard let friends = player.friends else { return }
            self.friends = friends
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
        self.tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "cell")
    }
}

extension GenericTableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerTableViewCell
        if let player = self.player {
            cell.buildCell()
            cell.player = self.friends[indexPath.row]
        }
        return cell
    }
    
}
