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
import TwitterKit

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    
    let loginStack = LoginButtonStackView()
    let twitterBtn = TWTRLogInButton()
    let signOutButton = UIButton()
    let doneButton = UIButton()
    
    var userInfo: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()?.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        var darkBlur:UIBlurEffect = UIBlurEffect()
        darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurView.alpha = 0.5
        view.addSubview(blurView)
        self.navigationController?.buildStaticNavBar()
        self.navigationController?.navigationBar.isHidden = true
        
        setupLoginStack()
        setupTwitterButton()
        setupGoogleButtons()
        buildDoneButton()
        buildSignout()
        
    }
    
    func setupLoginStack() {
        self.view.addSubview(loginStack)
        self.loginStack.translatesAutoresizingMaskIntoConstraints = false
        self.loginStack.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        self.loginStack.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        self.loginStack.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.60).isActive = true
        self.loginStack.heightAnchor.constraint(equalTo: self.loginStack.widthAnchor, multiplier: 1/3).isActive = true
    }
    
    //MARK: Twitter Login Methods
    func setupTwitterButton() {
        let logInButton = TWTRLogInButton { (session, error) in
            if let unwrappedSession = session {
                let alert = UIAlertController(title: "Logged In", message: "User \(unwrappedSession.userName) has logged in", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
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
                self.present(alert, animated: true, completion: nil)
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
        view.addSubview(logInButton)
        logInButton.translatesAutoresizingMaskIntoConstraints = false
        logInButton.topAnchor.constraint(equalTo: self.loginStack.bottomAnchor, constant: 25).isActive = true
        logInButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 10).isActive = true
    }
    
    // MARK: Google Login Methods
    fileprivate func setupGoogleButtons() {
        GIDSignIn.sharedInstance().uiDelegate = self
    }
    
    //  GIDSignInDelegate protcol methods. It handles the sign in process
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("Failed to log into Google:", error)
            return
        } else {
            print ("Successfully logged in")
        }
        guard let idToken = user.authentication.idToken,
            let accessToken = user.authentication.accessToken else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: idToken, accessToken: accessToken)
        
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if let error = error {
                print( "Failed to create a Firebase User with Google account:", error)
            }
            guard let uid = user?.uid else { return }
            print("Successfully logged into FIrebase with", uid)
        })
    }
    
    //  Google sign out
    func buildSignout() {
        self.view.addSubview(self.signOutButton)
        self.signOutButton.translatesAutoresizingMaskIntoConstraints = false
        self.signOutButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.signOutButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.signOutButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.signOutButton.heightAnchor.constraint(equalToConstant: 100).isActive = true
        self.signOutButton.setTitle("Sign out", for: .normal)
        self.signOutButton.setTitleColor(UIColor.red, for: .normal)
        self.signOutButton.addTarget(self, action: #selector(self.signOut), for: .touchUpInside)
    }
    
    func buildDoneButton(){
        self.view.addSubview(self.doneButton)
        self.doneButton.translatesAutoresizingMaskIntoConstraints = false
        self.doneButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -25).isActive = true
        self.doneButton.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        self.doneButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 1/3).isActive = true
        self.doneButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.doneButton.layer.cornerRadius = 10
        self.doneButton.setTitle("I've Logged In!", for: .normal)
        self.doneButton.backgroundColor = UIColor.blue
        self.doneButton.addTarget(self, action: #selector(self.doneButtonTapped), for: .touchUpInside)
    }
    
    func doneButtonTapped() {
        if FIRAuth.auth()?.currentUser == nil {
            let alert = UIAlertController(title: "Don't Lie to Me!", message: nil, preferredStyle: .alert)
            let sorryAction = UIAlertAction(title: "I'm Sorry :(", style: .cancel, handler: nil)
            alert.addAction(sorryAction)
            self.present(alert, animated: true, completion: nil)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    func signOut() {
        do {
            print("Signing out")
            try GIDSignIn.sharedInstance().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
}
