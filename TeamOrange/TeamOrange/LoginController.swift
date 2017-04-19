//
//  LoginViewController.swift
//  TeamOrange
//
//  Created by Michael on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit
import Firebase
import GoogleSignIn
import FBSDKLoginKit
import TwitterKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, FBSDKLoginButtonDelegate {
    
    let loginStack = LoginButtonStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var darkBlur:UIBlurEffect = UIBlurEffect()
        darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 0.5
        view.addSubview(blurView)
        
        let loginWtihLabel = UILabel()
        loginWtihLabel.font = UIFont(name: loginWtihLabel.font.fontName, size: 25)
        loginWtihLabel.text = "Sign in with"
        
        let exitBtn: UIButton = UIButton()
        exitBtn.addTarget(self, action: #selector(self.exitPressed), for: .touchUpInside)
        exitBtn.setImage(#imageLiteral(resourceName: "exit"), for: .normal)
        
        self.view.addSubview(loginWtihLabel)
        self.view.addSubview(loginStack)
        self.view.addSubview(exitBtn)
        
        loginWtihLabel.translatesAutoresizingMaskIntoConstraints = false
        loginWtihLabel.bottomAnchor.constraint(equalTo: loginStack.topAnchor, constant: -50).isActive = true
        loginWtihLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        self.loginStack.translatesAutoresizingMaskIntoConstraints = false
        self.loginStack.topAnchor.constraint(equalTo: loginWtihLabel.bottomAnchor, constant: 20).isActive = true
        self.loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.loginStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.loginStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.60).isActive = true
        self.loginStack.heightAnchor.constraint(equalTo: self.loginStack.widthAnchor, multiplier: 1/3).isActive = true
        
        exitBtn.translatesAutoresizingMaskIntoConstraints = false
        exitBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        exitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        exitBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        exitBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
        
        self.navigationController?.buildStaticNavBar()
        
        let googleButton = GIDSignInButton()
        googleButton.frame = CGRect(x: 16, y: 116 + 66, width: view.frame.width - 32, height: 50)
        view.addSubview(googleButton)
        GIDSignIn.sharedInstance().uiDelegate = self
        
        let fbLoginBtn = FBSDKLoginButton()
        fbLoginBtn.frame = CGRect(x: 16, y: 50, width: view.frame.width - 32, height: 50)
        view.addSubview(fbLoginBtn)
        fbLoginBtn.delegate = self
        fbLoginBtn.readPermissions = ["email", "public_profile"]
        setupTwitterButton()
        
        self.navigationController?.navigationBar.isHidden = false
        
    }
    
    func setupTwitterButton() {
        let twitterBtn = TWTRLogInButton { (session, error) in
            if let error = error {
                print("Failed to login via Twitter")
                return
            }
            
//            print("Succesfully logged in under Twiter")
            guard let token = session?.authToken else { return }
            guard let secret = session?.authTokenSecret else { return }
            
            let credentials = FIRTwitterAuthProvider.credential(withToken: token, secret: secret)
            
            FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
                if let error = error {
                    print("Failed to login in Firebase with Twitter", error)
                    return
                }
                
                print("Succesfully created a FIrebase-Twitter user", user?.uid ?? "")
            })
        }
        view.addSubview(twitterBtn)
        twitterBtn.frame = CGRect(x: 16, y: 50 + 50, width: view.frame.width - 32, height: 50)
            
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("signed out of fb")
    }
    
    func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
        if error != nil {
            print(error)
            return
        }
        getEmailFromUser()
    }
    
    func getEmailFromUser() {
        let accessToken = FBSDKAccessToken.current()
        guard let accessTokenString = accessToken?.tokenString else { return }
        let credentials = FIRFacebookAuthProvider.credential(withAccessToken: accessTokenString)
        FIRAuth.auth()?.signIn(with: credentials, completion: { (user, error) in
            if error != nil {
                print("Something went wrong with our FB user:", user ?? "")
                return
            }
            print("Successfully logged in with our user: ", user ?? "")
        })
        
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, error) in
            if error != nil {
                print("Failed to start graph request:", error ?? "")
                return
            }
            print(result ?? "")
        }
    }
    
    
    func exitPressed() {
        self.dismiss(animated: true)
    }
    
}
