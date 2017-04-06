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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit() {
        self.backgroundColor = UIColor.clear
        
        let views: [UIView] = [searchBar, okButton, cancelButton]
        views.forEach({ view in
            self.addSubview(view)
            view.translatesAutoresizingMaskIntoConstraints = false
            view.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
            view.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
            view.backgroundColor = UIColor.lightGray
        })
        
        searchBar.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        searchBar.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        okButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.125).isActive = true
        okButtonConstraint = NSLayoutConstraint(item: okButton, attribute: .trailing, relatedBy: .equal, toItem: searchBar, attribute: .leading, multiplier: 1, constant: 50)
        self.addConstraint(okButtonConstraint)
        self.insertSubview(okButton, belowSubview: searchBar)
        okButton.backgroundColor = UIColor.green
        okButton.setTitle("-O", for: .normal)
        
        cancelButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.125).isActive = true
        cancelButtonConstraint = NSLayoutConstraint(item: cancelButton, attribute: .leading, relatedBy: .equal, toItem: searchBar, attribute: .trailing, multiplier: 1, constant: -50)
        self.addConstraint(cancelButtonConstraint)
        self.insertSubview(cancelButton, belowSubview: searchBar)
        cancelButton.backgroundColor = UIColor.red
        cancelButton.setTitle("X", for: .normal)
    }
    
    func activateButtons(state: Bool, completion: @escaping ()->()) {
        if state == true{
            self.okButtonConstraint.constant = 0
            self.cancelButtonConstraint.constant = 0
        } else {
            self.okButtonConstraint.constant = 50
            self.cancelButtonConstraint.constant = -50
        }
        UIView.animate(withDuration: 0.5, animations: {
            self.layoutIfNeeded()
        }, completion: { done in
            completion()
        })
    }
}
