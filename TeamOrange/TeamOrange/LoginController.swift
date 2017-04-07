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
    
    let loginStack = LoginButtonStackView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var darkBlur:UIBlurEffect = UIBlurEffect()
        darkBlur = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: darkBlur)
        blurView.frame = self.view.frame
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
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
        self.loginStack.heightAnchor.constraint(equalTo: self.loginStack.widthAnchor, multiplier: 1/4).isActive = true
        
        exitBtn.translatesAutoresizingMaskIntoConstraints = false
        exitBtn.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        exitBtn.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        exitBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50).isActive = true
        exitBtn.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.10).isActive = true
        exitBtn.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15).isActive = true
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
