//
//  SportPickerController.swift
//  TeamOrange
//
//  Created by William Brancato on 4/7/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation
import UIKit

class SportPickerController: UIViewController {
    
    var chosenSports: [Sport] = [] { didSet { self.myView.topView.tableView.reloadData() } }
    
    let myView = SportPickerView()
    var leadingConstraintVisible: NSLayoutConstraint!
    var leadingConstraintInvisible: NSLayoutConstraint!
    let button = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.buildView()
        NotificationCenter.default.addObserver(self, selector: #selector(self.addChosenSport), name: Notification.Name("Sport Chosen"), object: nil)
        NotificationCenter.default.addObserver(self.myView, selector: #selector(self.myView.collapse), name: Notification.Name("Collapse Picker"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.slideViewOut), name: Notification.Name("Picker Collapsed"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.slideViewIn()   
        self.myView.topView.tableView.delegate = self
        self.myView.topView.tableView.dataSource = self
    }
    
    
    func buildView() {
        self.view.addSubview(self.myView)
        self.myView.translatesAutoresizingMaskIntoConstraints = false
        self.myView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.myView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        self.leadingConstraintVisible = self.myView.leadingAnchor.constraint(equalTo: self.view.trailingAnchor); self.leadingConstraintVisible.isActive = true
        self.leadingConstraintInvisible = self.myView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor); self.leadingConstraintInvisible.isActive = false
        self.myView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier: 0.4).isActive = true
        
    }
    
    func slideViewIn() {
        self.leadingConstraintVisible.isActive = false
        self.leadingConstraintInvisible.isActive = true
        UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() }
                                         , completion: { _ in self.myView.build() })
    }
    
    func slideViewOut() {
        self.leadingConstraintVisible.isActive = true
        self.leadingConstraintInvisible.isActive = false
        UIView.animate(withDuration: 0.25, animations: { self.view.layoutIfNeeded() }
                                         , completion: { _ in self.dismiss(animated: false) })
    }
    
    func addChosenSport(notification: Notification) {
        guard let sport = notification.object as? Sport else { return }
        self.chosenSports.append(sport)
    }
    
}

extension SportPickerController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.chosenSports.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sportCell", for: indexPath) as! ChosenSportTableCell
        cell.sport = self.chosenSports[indexPath.row]
        return cell
    }
    
}
