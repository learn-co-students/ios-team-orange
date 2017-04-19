//
//  TableViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/19/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController {

    var searchPurpose: SearchPurpose?
    var players: [Player]? = nil
    var playerResults: [Player]? = nil
    var games: [Game]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if searchPurpose == .findManyPlayers {
            playerResults = []
        }
        if searchPurpose == .findGame {
            games = []
        } else {
            players = []
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        if searchPurpose == SearchPurpose.findManyPlayers { return 3 }
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let purpose = searchPurpose else {return 0}
        switch purpose{
        case .findManyPlayers:
            if section == 0 { return 1}
            if section == 1 { return playerResults!.count }
            if section == 2 { return players!.count }
        case .findOnePlayer:
            return players!.count
        case .findGame:
            return games!.count
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        guard let purpose = searchPurpose else 
        switch searchPurpose{
        case .findManyPlayers:
            if section == 0 { cell = tableView.dequeueReusableCell(withIdentifier: "searchCell")}
            if section == 1 { cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath.row) }
            if section == 2 { return players!.count }
        case .findOnePlayer:
            return players!.count
        case .findGame:
            return games!.count
        }
        }
        
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
