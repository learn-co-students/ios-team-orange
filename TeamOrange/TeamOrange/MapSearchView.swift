//
//  MapViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit
import MapKit

class MapSearchView: UIView {
    /*
     IMPORTANT!!!!!
     assign MapSearchView.mapView to "weak var mapView!" in VC and adopt the MapUpdater protocol!
     
     */
    lazy var mapView = MKMapView()
    lazy var searchBarView: SearchBarView = SearchBarView()
    var searchBarViewActive = false
    var searchBarConstraint = NSLayoutConstraint()
    lazy var searchButton = UIButton()
    var searchButtonConstraint = NSLayoutConstraint()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func commonInit(){
        self.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mapView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mapView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButtonConstraint = NSLayoutConstraint(item: searchButton, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 20)
        self.addConstraint(searchButtonConstraint)
        searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.077).isActive = true
        searchButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.14).isActive = true
        searchButton.layer.cornerRadius = 29
        searchButton.setTitle("-O", for: .normal)
        self.insertSubview(searchButton, aboveSubview: mapView)
        
        self.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.heightAnchor.constraint(equalToConstant: 35).isActive = true
        searchBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        searchBarConstraint = NSLayoutConstraint(item: searchBarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: -50)
        self.addConstraint(searchBarConstraint)
        searchBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.insertSubview(searchBarView, aboveSubview: mapView)
    }
    
    func animateSearchBar(){
        if searchBarViewActive{
            searchBarView.activateButtons(state: false, completion: {
                self.searchBarConstraint.constant = -50
                self.searchButtonConstraint.constant = 20
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                    self.searchBarViewActive = false
                })
            })
        } else {
            self.searchBarConstraint.constant = 50
            self.searchButtonConstraint.constant = -50
            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()
            }, completion: { _ in
                self.searchBarView.activateButtons(state: true, completion: {})
                self.searchBarViewActive = true
            })
        }
    }
}

