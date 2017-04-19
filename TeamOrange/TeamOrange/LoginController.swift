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

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate, FBSDKLoginButtonDelegate {
    
    let loginStack = LoginButtonStackView()
    let googleBtn = GIDSignInButton()
    let twitterBtn = TWTRLogInButton()
    let signOutButton = UIButton()
    
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
        
        setupLoginStack()
        setupFacebookButton()
        setupTwitterButton()
        setupGoogleButtons()
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
        view.addSubview(googleBtn)
        googleBtn.translatesAutoresizingMaskIntoConstraints = false
        googleBtn.topAnchor.constraint(equalTo: self.loginStack.bottomAnchor, constant: 75).isActive = true
        googleBtn.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 10).isActive = true
        //        let customButton = UIButton(type: .system)
        //        customButton.frame = CGRect(x: 16, y: 116 + 66 + 66, width: view.frame.width - 32, height: 50)
        //        customButton.backgroundColor = .orange
        //        customButton.setTitle("Custom Google Sign In", for: .normal)
        //        customButton.addTarget(self, action: #selector(handleCustomGoogleSign), for: .touchUpInside)
        //        customButton.setTitleColor(.white, for: .normal)
        //        customButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        //        view.addSubview(customButton)
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
    
    func signOut() {
        do {
            print("Signing out")
            try GIDSignIn.sharedInstance().signOut()
        } catch let signOutError as NSError {
            print ("Error signing out: %@", signOutError)
        }
    }
    
    //MARK: Facebook Login Methods
    fileprivate func setupFacebookButton() {
        let loginButton = FBSDKLoginButton()
        view.addSubview(loginButton)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.topAnchor.constraint(equalTo: self.loginStack.bottomAnchor, constant: 125).isActive = true
        loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 10).isActive = true
        loginButton.delegate = self
        loginButton.readPermissions = ["email", "public_profile"]
        
        //add our custom fb login button here
        //        let customFBButton = UIButton(type: .system)
        //        customFBButton.backgroundColor = .blue
        //        customFBButton.frame = CGRect(x: 16, y: 116, width: view.frame.width - 32, height: 50)
        //        customFBButton.setTitle("Custom FB Login here", for: .normal)
        //        customFBButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        //        customFBButton.setTitleColor(.white, for: .normal)
        //        view.addSubview(customFBButton)
        //        customFBButton.addTarget(self, action: #selector(handleCustomFBLogin), for: .touchUpInside)
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
                print("Something went wrong with our FB user: ", error ?? "")
                return
            }
            print("Successfully logged in with our user: ", user ?? "")
        })
        FBSDKGraphRequest(graphPath: "/me", parameters: ["fields": "id, name, email"]).start { (connection, result, err) in
            if err != nil {
                print("Failed to start graph request:", err ?? "")
                return
            }
            print(result ?? "")
        }
    }
}
