//
//  ViewController.swift
//  mapSearchTableViewTest
//
//  Created by Edmund Holderbaum on 4/5/17.
//  Copyright © 2017 Bozo Design Labs. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import FirebaseDatabase

class MapViewController: UIViewController {
    
    lazy var mainView: MapSearchView = MapSearchView()
    let loginButton = UIButton()
    
    override func loadView() {
        super.loadView()
        self.view = mainView
        self.mainView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
        mainView.searchBarView.searchBar.delegate = self
//        mainView.searchTable.delegate = self
//        mainView.searchTable.dataSource = self
        //mainView.searchTable.register(SearchCell.self, forCellReuseIdentifier: "SearchCell")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Huddle"
        
        // set the nav bar to clear
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        
        self.buildLoginButton()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchButtonClicked() {
        self.mainView.animateSearchBar()
    }
    
    func buildLoginButton() {
        self.view.addSubview(loginButton)
        self.loginButton.translatesAutoresizingMaskIntoConstraints = false
        self.loginButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        self.loginButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        self.loginButton.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.05).isActive = true
        self.loginButton.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.2).isActive = true
        self.loginButton.backgroundColor = UIColor.red
        self.loginButton.setTitle("Login", for: .normal)
        self.loginButton.addTarget(self, action: #selector(self.goToLoginScreen), for: .touchUpInside)
    }
    
    func goToLoginScreen() {
        let loginScreen = LoginViewController()
        loginScreen.modalPresentationStyle = .overCurrentContext
        self.present(loginScreen, animated: true, completion: nil)
    }
}

extension MapViewController: UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.returnKeyType = .search
    }
    
//    func textFieldDidEndEditing(_ textField: UITextField) {
//
//        textFieldShouldHide(textField)
//        return
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard textField.text != "" else {
            return false
        }
        textField.endEditing(true)
        return true
    }
}



//extension ViewController: UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = mainView.searchTable.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchCell
//        cell.searchBar.delegate = self
//        return cell
//    }
//    
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        mainView.searchTable.setEditing(true, animated: false)
//    }
//}

