//
//  HomeRearViewController.swift
//  TeamOrange
//
//  Created by Michael on 4/11/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit

class HomeRearViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let fakeDataArray = ["Profile", "Home", "Friends", "Create Game"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .blue
        let tableView: UITableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        tableView.dataSource = self
        tableView.delegate = self
        tableView.addAndConstrainToEdges(of: self.view)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fakeDataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath)
        cell.textLabel?.text = "\(fakeDataArray[indexPath.row])"
        return cell
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
