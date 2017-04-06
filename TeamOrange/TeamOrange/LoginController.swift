//
//  LoginViewController.swift
//  TeamOrange
//
//  Created by Michael on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
import FirebaseAuth

class LoginViewController: UIViewController {
    
    let button = UIButton(frame:CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildButton()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildButton() {
        self.view.addSubview(self.button)
        self.button.translatesAutoresizingMaskIntoConstraints = false
        self.button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.button.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.2).isActive = true
        self.button.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.3).isActive = true
        self.button.backgroundColor = UIColor.black
        self.button.addTarget(self, action: #selector(self.fillDatabaseWithArrays), for: .touchUpInside)
    }
    
    func fillDatabaseWithBaseData() {
        for num in 1...30 {
            let playerInfo : [String:Any] = [
                "birthDate" : "9/\(num)/1986",
                "favSport" : "Baseball",
                "gender" : "male",
                "homeField" : "Dingletown",
                "homeTown" : "Medford",
                "imageUrlString" : "www.url.com",
                "name" : "username\(num)",
                "zipCode" : "33021"
            ]
            
            FirebaseClient.createPlayer(with: playerInfo)
            
            let teamInfo : [String:Any] = [
                "color" : "blue",
                "homeField" : "Shea Stadium",
                "imageUrlString" : "www.url.com",
                "name" : "NYC All Stars \(num)"
            ]
            
            FirebaseClient.createTeam(with: teamInfo)
            
            let gameInfo: [String:Any] = [
                "date" : "9/\(num)/2017",
                "name" : "Game \(num)",
                "over" : true,
                "success" : false,
                "sport" : "Baseball",
                "state" : "Not Started"
            ]
            
            FirebaseClient.createGame(with: gameInfo)
        }
    }
    
    func fillDatabaseWithArrays() {
        var playerKeys: [String] = []
        var teamKeys: [String] = []
        var gameKeys: [String] = []
        FIRDatabase.database().reference().child("players").observeSingleEvent(of: .value, with: { snapshot in
            let snapshot = snapshot.value as? [String:Any]
            for snap in snapshot! {
                playerKeys.append(snap.key)
            }
            FIRDatabase.database().reference().child("teams").observeSingleEvent(of: .value, with: { snapshot in
                let snapshot = snapshot.value as? [String:Any]
                for snap in snapshot! {
                    teamKeys.append(snap.key)
                }
                FIRDatabase.database().reference().child("games").observeSingleEvent(of: .value, with: { snapshot in
                    let snapshot = snapshot.value as? [String:Any]
                    for snap in snapshot! {
                        gameKeys.append(snap.key)
                    }
                })
            })
        })
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
