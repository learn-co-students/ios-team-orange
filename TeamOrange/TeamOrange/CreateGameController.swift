//
//  ViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/17/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class CreateGameController: UIViewController {
    lazy var mainView: CreateGameView = CreateGameView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.buildStaticNavBar()
        self.title = "Create Game"
        self.view = mainView
        mainView.addSubview(mainView.mapView)
        mainView.mapView.translatesAutoresizingMaskIntoConstraints = false
        mainView.mapView.topAnchor.constraint(equalTo: self.topLayoutGuide.bottomAnchor).isActive = true
        mainView.mapView.leadingAnchor.constraint(equalTo: mainView.leadingAnchor).isActive = true
        mainView.mapView.trailingAnchor.constraint(equalTo: mainView.trailingAnchor).isActive = true
        mainView.mapView.heightAnchor.constraint(equalTo: mainView.widthAnchor, multiplier: 0.3).isActive = true
        mainView.setupSubviews()
        mainView.createButton.addTarget(self, action: #selector(printSelectedSport), for: .touchUpInside)
        print ("CGC viewDidLoad")
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func printSelectedSport(){
        print(mainView.selectedSport ?? "nil")
    }

}
