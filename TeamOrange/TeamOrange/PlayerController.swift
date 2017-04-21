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
    var isCurrentPlayer = false
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
        isCurrentPlayer = player.id == CurrentPlayer.player.id
        if !isCurrentPlayer {
            myView.buildFriendButton(player: player, isFriend: isAFriend)
        }
        NotificationCenter.default.addObserver(self, selector: #selector(friendAlert), name: NSNotification.Name(rawValue: "Added Friend"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(confirmRemoveAsFriend), name: NSNotification.Name(rawValue: "AskedToRemoveFriend"), object: nil)
    }
    
    
    var isAFriend: Bool {
        return CurrentPlayer.player.friends.contains(where: {$0.id == player.id})
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
        } else if let propertyValue = self.player.propertyDictionary[self.player.propertyArray[indexPath.row]] as? [Any]{
            var cell = tableView.dequeueReusableCell(withIdentifier: "detailCell")
            if (cell == nil) {
                cell = UITableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "detailCell")
            }
            cell!.textLabel?.text = self.player.propertyArray[indexPath.row]
            cell!.detailTextLabel?.text = "\(self.player.propertyArray[indexPath.row]): \(propertyValue.count)"
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
    }
    
    func friendAlert() {
        player.fillArrays {
            self.myView.tableView.reloadData()
        }
        let alert = UIAlertController(title: "Added \(self.player.name ?? "ERROR") ", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Got It", style: .default, handler: nil)
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func arrayDetailText(index: Int, array: [Any])-> String {
        var numericalString = "\(array.count)"
        var propertyString = "\(self.player.propertyArray[index])"
        if array.count == 1 {
            numericalString = "one"
            let stringArray = propertyString.characters.dropLast()
            propertyString = ""
            propertyString.append(contentsOf: stringArray)
        }
        if isCurrentPlayer {
            return "You currently have: \(numericalString) \(propertyString)"
        }
        return "\(player.name ?? "ERROR") currently has: \(numericalString) \(propertyString)"
    }
    
    func confirmRemoveAsFriend(){
        let alert = UIAlertController(title: "Remove \(self.player.name ?? "ERROR") from friends?", message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Do it", style: .destructive, handler: { action in
            RemoveFromFirebase.friend(of: CurrentPlayer.player.id, withId: self.player.id, completion: {
                self.reloadData(){
                    let alert = UIAlertController(title: "Removed \(self.player.name ?? "ERROR") ", message: nil, preferredStyle: .alert)
                    let okAction = UIAlertAction(title: "Got It", style: .default, handler: nil)
                    alert.addAction(okAction)
                    self.present(alert, animated: true, completion: nil)
                }
            })
        })
        let cancelAction = UIAlertAction(title: "Never mind", style: .default, handler: nil)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func reloadData(completion: @escaping ()->()){
        print("reload data")
        self.player.fillArrays {
            print ("fill arays done")
            let friendButton = self.myView.friendButton as! AddFriendButton
            friendButton.changeImage()
            completion()
        }
    }
}

