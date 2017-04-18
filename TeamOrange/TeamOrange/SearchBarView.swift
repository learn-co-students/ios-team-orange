//
//  SearchBarView.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//


import UIKit

class SearchBarView: UIView {
    
    lazy var searchBar = UITextField()
    lazy var okButton = UIButton()
    var okButtonConstraint = NSLayoutConstraint()
    lazy var cancelButton = UIButton()
    var cancelButtonConstraint = NSLayoutConstraint()
    lazy var tableView = UITableView()
    var tableViewConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        let blurView = BlurView(blurEffect: .dark)
        blurView.alpha = 0.5
        blurView.addAndConstrainToEdges(of: self)
        
        let views: [UIView] = [searchBar, okButton, cancelButton]
        views.forEach({ view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.heightAnchor.constraint(equalToConstant: 25).isActive = true
            view.backgroundColor = UIColor.clear
        })
        
        searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.8).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchBar.returnKeyType = .search
        
        okButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        okButtonConstraint = NSLayoutConstraint(item: okButton, attribute: .trailing, relatedBy: .equal, toItem: searchBar, attribute: .leading, multiplier: 1, constant: 50)
        self.addConstraint(okButtonConstraint)
        self.insertSubview(okButton, belowSubview: searchBar)
        okButton.setTitle("-O", for: .normal)
        
        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.1).isActive = true
        cancelButtonConstraint = NSLayoutConstraint(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: searchBar, attribute: .trailing, multiplier: 1, constant: -50)
        self.addConstraint(cancelButtonConstraint)
        self.insertSubview(cancelButton, belowSubview: searchBar)
        cancelButton.setTitle("X", for: .normal)
        
        self.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableViewConstraint = NSLayoutConstraint(item: tableView, attribute: .bottom, relatedBy: .equal, toItem: searchBar, attribute: .bottom, multiplier: 1, constant: 0)
        self.addConstraint(tableViewConstraint)
        tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: okButton.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: cancelButton.trailingAnchor, constant: 0).isActive = true
        tableView.backgroundColor = UIColor.clear
        tableView.register(CompletionCell.self, forCellReuseIdentifier: "completionCell")
        tableView.isUserInteractionEnabled = true
    }
    
    func animateSelf(state: Bool, completion: @escaping ()->()) {
        UIView.animate(withDuration: 0.25, animations: {
            self.layoutIfNeeded()
        }, completion: { done in
            self.searchBar.text = ""
            if state == true{
                self.tableViewConstraint.constant = 300
            } else {
                self.tableViewConstraint.constant = 0
            }
            UIView.animate(withDuration: 0.25, animations: { self.layoutIfNeeded() }, completion: { _ in completion ()})
        })
    }
    
    func activateSelf(completion: @escaping ()->()) {
        self.okButtonConstraint.constant = 0
        self.cancelButtonConstraint.constant = 0
        animateSelf(state: true, completion: {completion()})
    }
    
    func deactivateSelf(completion: @escaping ()->()) {
        self.okButtonConstraint.constant = 25
        self.cancelButtonConstraint.constant = -25
        animateSelf(state: false, completion: {completion()})
    }
}
