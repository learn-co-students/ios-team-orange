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
        self.button.addTarget(self, action: #selector(self.queryData), for: .touchUpInside)
    }
    
    func updateData() {
        for num in 1...30 {
            let userInfo : [String:Any] = ["name" : "userNamel\(num)",
                "favSport" : Sport.basketball.rawValue,
                "gender" : Gender.female.rawValue,
                "homeField" : "Russel Sage Park",
                "homeTown" : "Manhatten",
                "profPic" : "www.url.com",
                "zipCode" : 33021]
            FirebaseClient.createUser(with: userInfo)
        }
    }
    
    func queryData() {
        FirebaseClient.getUsersWith(displayName: "BillyFuckinB"){ users in
            print(users)
        }
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
