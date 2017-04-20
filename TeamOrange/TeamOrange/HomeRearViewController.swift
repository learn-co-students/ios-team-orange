//
//  HomeRearViewController.swift
//  TeamOrange
//
//  Created by Michael on 4/11/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class HomeRearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let mapView = MapSearchView()
    
    let tableFieldsArray = ["Profile", "Friends", "Players", "Create Game"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let tableView: UITableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addAndConstrainToEdges(of: self.view)
        self.revealViewController().rearViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().rearViewController.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().tapGestureRecognizer())
        //        mapView.mainView.mapView.isUserInteractionEnabled = false
        //        mapView.mainView.mapView.isScrollEnabled = false
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.revealViewController().frontViewController.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        self.revealViewController().frontViewController.view.isUserInteractionEnabled = true
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableFieldsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        
        cell.textLabel?.text = "\(tableFieldsArray[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        CurrentPlayer.player.fillArrays {
            switch indexPath.row{
            case 0:
                let playerController = PlayerController()
                playerController.player = CurrentPlayer.player
                self.navigationController?.pushViewController(playerController, animated: true)
                break
            case 1:
                let playerTableView = PlayerTableViewController()
                playerTableView.player = CurrentPlayer.player
                self.navigationController?.pushViewController(playerTableView, animated: true)
                break
            case 2:
                let playerSearchController = PlayerSearchViewController()
                self.navigationController?.pushViewController(playerSearchController, animated: true)
                break
            case 3:
                let createGameController = CreateGameController()
                self.navigationController?.pushViewController(createGameController, animated: false)
                break
            default:
                return
            }
        }
    }
}
