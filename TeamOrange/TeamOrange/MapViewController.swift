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

class MapViewController: UIViewController {
    
    lazy var mainView: MapSearchView = MapSearchView()
    
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
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func searchButtonClicked() {
        print ("yo")
        self.mainView.animateSearchBar()
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

