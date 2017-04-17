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


class LoginViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    
    let loginStack = LoginButtonStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        GIDSignIn.sharedInstance().signIn()
        
//        let blue = BlurView(blurEffect: .dark)
//        self.view.addSubview(blurView)
        
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
        
        
    }
    
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        // ...
        if let error = error {
            // ...
            return
        }
        
        guard let authentication = user.authentication else { return }
        let credential = FIRGoogleAuthProvider.credential(withIDToken: authentication.idToken,
                                                          accessToken: authentication.accessToken)
        // ...
    }
    
    func exitPressed() {
        self.dismiss(animated: true)
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
