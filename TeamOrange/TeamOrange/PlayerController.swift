//
//  PlayerController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class PlayerController: UIViewController, PlayerViewDelegate {
    
    let myView: PlayerView = PlayerView()
    var player: Player! {
        didSet {
            self.player.fillArrays {
                self.myView.playerDelegate = self
                self.myView.tableView.delegate = self
                self.myView.tableView.dataSource = self
                self.myView.buildView()
                self.myView.buildNameLabel()
            }
        }
    }
    
    override func viewDidLoad() {
        self.navigationController?.buildStaticNavBar()
        self.addAndConstrain(view: self.myView)
        self.navigationController?.navigationBar.isHidden = false
    }
}

extension PlayerController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.player.propertyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let propertyValue = self.player.propertyDictionary[self.player.propertyArray[indexPath.row]] as? String {
            var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell")
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "detailCell")
            }
            cell!.textLabel?.text = propertyValue
            cell!.detailTextLabel?.text = self.player.propertyArray[indexPath.row]
            cell!.detailTextLabel?.textColor = UIColor.lightGray
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            cell.textLabel?.text = self.player.propertyArray[indexPath.row]
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 4:
            let playerTableView = PlayerTableViewController()
            playerTableView.player = self.player
            self.navigationController?.pushViewController(playerTableView, animated: true)
        case 5:
            let gameTableView = GameTableViewController()
            gameTableView.player = self.player
            self.navigationController?.pushViewController(gameTableView, animated: true)
        case 6: print("Soon")
        default:
            break
        }
        if indexPath.row == 4  {
            
            
        }
    }
}
