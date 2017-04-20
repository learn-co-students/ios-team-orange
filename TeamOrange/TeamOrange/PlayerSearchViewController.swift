//
//  PlayerSearchViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/19/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class PlayerSearchViewController: UIViewController {

    var players = [Player]()
    lazy var searchBar = UISearchBar()
    lazy var tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.buildStaticNavBar()
        self.navigationController?.navigationBar.isHidden = false
        
        self.view.addSubview(searchBar)
        searchBar.delegate = self
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        searchBar.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        searchBar.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        searchBar.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        searchBar.placeholder = "Search Players"
        
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(PlayerTableViewCell.self, forCellReuseIdentifier: "playerCell")
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension PlayerSearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath) as! PlayerTableViewCell
        cell.player = self.players[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let playerController = PlayerController()
        playerController.player = self.players[indexPath.row]
        self.navigationController?.pushViewController(playerController, animated: true)
    }
}

extension PlayerSearchViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let name = searchBar.text, name != "" else {
            print ("no text")
            searchBar.resignFirstResponder()
            return
        }
        QueryFirebase.forPlayersWith(name: name, completion: { results in
            self.players = results
            print("search came back")
            DispatchQueue.main.async {
                self.tableView.reloadData()
                searchBar.resignFirstResponder()
            }
        })
    }
    
    
}









