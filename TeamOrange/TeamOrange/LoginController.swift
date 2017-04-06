//
//  LoginViewController.swift
//  TeamOrange
//
//  Created by Michael on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit
import Firebase


class LoginViewController: UIViewController {
    
    let button = UIButton(frame:CGRect.zero)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let doneItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(self.donePressed))
        
        let loginWtihLabel = UILabel()
        loginWtihLabel.font = UIFont(name: loginWtihLabel.font.fontName, size: 25)
        loginWtihLabel.text = "-------- Login with --------"
        
        

        let facebookLoginBtn = LoginButton(title: "f", image: nil, backgroundColor: .blue)
        let twitterLoginBtn = LoginButton(title: "t", image: nil, backgroundColor: .cyan)
        let gmailBtn = LoginButton(title: "G", image: nil, backgroundColor: .red)
        
        self.view.addSubview(loginWtihLabel)
        self.view.addSubview(facebookLoginBtn)
        self.view.addSubview(twitterLoginBtn)
        self.view.addSubview(gmailBtn)
        
        
        // should be anchored atop center button
        loginWtihLabel.translatesAutoresizingMaskIntoConstraints = false
        loginWtihLabel.bottomAnchor.constraint(equalTo: twitterLoginBtn.topAnchor, constant: -20).isActive = true
        loginWtihLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // left button
        facebookLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        facebookLoginBtn.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        facebookLoginBtn.trailingAnchor.constraint(equalTo: twitterLoginBtn.leadingAnchor, constant: -50).isActive = true
        facebookLoginBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.077).isActive = true
        facebookLoginBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14).isActive = true
        facebookLoginBtn.layer.cornerRadius = 28
        
        // middle button
        twitterLoginBtn.translatesAutoresizingMaskIntoConstraints = false
        twitterLoginBtn.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        twitterLoginBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        twitterLoginBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.077).isActive = true
        twitterLoginBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14).isActive = true
        twitterLoginBtn.layer.cornerRadius = 29
        
        // right button
        gmailBtn.translatesAutoresizingMaskIntoConstraints = false
        gmailBtn.topAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        gmailBtn.leadingAnchor.constraint(equalTo: twitterLoginBtn.trailingAnchor, constant: 50).isActive = true
        gmailBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.077).isActive = true
        gmailBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.14).isActive = true
        gmailBtn.layer.cornerRadius = 28
        
        
//        let button = UIButton(type: .custom)
//        button.backgroundColor = .black
//        button.frame = CGRect(x: 160, y: 100, width: 50, height: 50)
//        button.layer.cornerRadius = 0.5 * button.bounds.size.width
//        button.clipsToBounds = true
//        view.addSubview(button)
        
        
    }

    func donePressed() {
        print("done pressed")
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
