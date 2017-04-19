//
//  GenericTableViewController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerTableViewController: UIViewController {
    
    let tableView = UITableView(frame: CGRect.zero)
    var friends: [Player] = []
    var player: Player? {
        didSet {
            guard let player = self.player else { return }
            self.friends = player.friends
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addAndConstrain(view: self.tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.navigationController?.buildStaticNavBar()
        self.tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "cell")
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension PlayerTableViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerTableViewCell
        if let player = self.player {
            cell.player = self.friends[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerController = PlayerController()
        playerController.player = self.friends[indexPath.row]
        self.navigationController?.pushViewController(playerController, animated: true)
    }
    
}
