//
//  LoginButtonStackView.swift
//  TeamOrange
//
//  Created by Michael on 4/5/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import Firebase
import GoogleSignIn
import TwitterKit

class LoginButtonStackView: UIStackView, GIDSignInDelegate {
    
    var facebookLoginBtn: LoginButton!
    var twitterLoginBtn: LoginButton!
    var gmailBtn: LoginButton!
    
    var loginBtnArray: [UIButton] = []
    init() {
        super.init(frame: CGRect.zero)
        self.facebookLoginBtn = LoginButton(image: #imageLiteral(resourceName: "facebook"), action: self.handleCustomFBLogin)
        self.twitterLoginBtn = LoginButton(image: #imageLiteral(resourceName: "twitter"), action: self.handleCustomTwitterLogin)
        self.gmailBtn = LoginButton(image: #imageLiteral(resourceName: "google-plus"), action: self.handleCustomGoogleSign)
        self.loginBtnArray = [self.facebookLoginBtn, self.twitterLoginBtn, self.gmailBtn]
        self.distribution = .fillEqually
        self.buildLoginStack()
        self.alignment = .fill
        //        self.spacing = 40
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func buildLoginStack() {
        loginBtnArray.forEach { (button) in
            self.addArrangedSubview(button)
        }
    }
    
    func handleCustomFBLogin() {
        FBSDKLoginManager().logIn(withReadPermissions: ["email", "public_profile"]) { (result, error) in
            if error != nil {
                print("Custom FB Login failed:", error)
                return
            }
            
            self.getEmailFromUser()
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton!) {
        print("signed out of fb")
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
    
    func handleCustomGoogleSign() {
        GIDSignIn.sharedInstance().signIn()
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
    
    func handleCustomTwitterLogin() {
        Twitter.sharedInstance().logIn { (session, error) in
            if session != nil {
                print("signed in as \(session!.userName)");
                let client = TWTRAPIClient.withCurrentUser()
                let request = client.urlRequest(withMethod: "GET",
                                                url: "https://api.twitter.com/1.1/account/verify_credentials.json?include_email=true",
                                                parameters: ["include_email": "true", "skip_status": "true"],
                                                error: nil)
                client.sendTwitterRequest(request) { response, data, connectionError in
                    if (connectionError == nil) {
                        do{
                            let json = try JSONSerialization.jsonObject(with: data!, options: .allowFragments) as! [String:Any]
                            print("Json response: ", json)
                            let firstName = json["name"]
                            let lastName = json["screen_name"]
                            let email = json["email"]
                            print("First name: ",firstName ?? "Morpheus")
                            print("Last name: ",lastName ?? "Mantinki")
                            print("Email: ",email ?? "noEmail@mikesEmail.org")
                        } catch {
                        }
                    }
                    else {
                        print("Error: \(connectionError)")
                    }
                }
            } else {
                NSLog("Login error: %@", error!.localizedDescription);
            }
        }
    }
}
