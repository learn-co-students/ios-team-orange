//
//  MapViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//merge 

import UIKit
import MapKit

class MapSearchView: UIView {
    lazy var mapView = MKMapView()
    lazy var searchBarView: SearchBarView = SearchBarView()
    var searchBarViewActive = false
    var searchBarConstraint = NSLayoutConstraint()
    lazy var searchButton = UIButton()
    lazy var centerMapButton = UIButton()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        self.commonInit()
        MapKitClient.setMap(to: mapView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
//        let gradient = CAGradientLayer()
//        gradient.startPoint = CGPoint(x: 0, y: 0)
//        gradient.endPoint = CGPoint(x: 100, y: 100)
//        gradient.backgroundColor = UIColor.blue.cgColor
//        self.layer.mask = gradient
        self.roundCorners(corners: [.topLeft, .topRight], radius: 10)
    }
    
    func commonInit(){
        mapView.addAndConstrainToEdges(of: self)
        
        self.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.bottomAnchor.constraint(equalTo: self.mapView.bottomAnchor, constant: -20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: self.mapView.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        searchButton.setImage(#imageLiteral(resourceName: "search"), for: .normal)
        self.insertSubview(searchButton, aboveSubview: mapView)

        self.addSubview(centerMapButton)
        centerMapButton.translatesAutoresizingMaskIntoConstraints = false
        centerMapButton.bottomAnchor.constraint(equalTo: self.bottomAnchor , constant: -10).isActive = true
        centerMapButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 35).isActive = true
        centerMapButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        centerMapButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        centerMapButton.layer.cornerRadius = 29
        centerMapButton.setTitle(">O<", for: .normal)
        centerMapButton.setTitle(">O<", for: .disabled)
        centerMapButton.setTitleColor(UIColor.white, for: .disabled)
        centerMapButton.setTitleColor(UIColor.red, for: .normal )
        self.insertSubview(centerMapButton, aboveSubview: mapView)
        
        self.addSubview(searchBarView)
        searchBarView.translatesAutoresizingMaskIntoConstraints = false
        searchBarView.heightAnchor.constraint(equalToConstant: 25).isActive = true
        searchBarView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.75).isActive = true
        searchBarConstraint = NSLayoutConstraint(item: searchBarView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: -50)
        self.addConstraint(searchBarConstraint)
        searchBarView.layer.cornerRadius = 5
        searchBarView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        self.insertSubview(searchBarView, aboveSubview: mapView)
    }
    
    func animateSearchBar(){
        if searchBarViewActive{
            searchBarView.deactivateSelf(completion: {
                self.searchBarConstraint.constant = -50
                UIView.animate(withDuration: 0.5, animations: {
                    self.layoutIfNeeded()
                    self.searchBarViewActive = false
                    self.searchBarView.searchBar.resignFirstResponder()
                })
            })
        } else {
            searchBarConstraint.constant = 64
            UIView.animate(withDuration: 0.5, animations: {
                self.layoutIfNeeded()
            } , completion: { _ in
                self.searchBarView.activateSelf(completion: {
                    self.searchBarView.becomeFirstResponder()
                    self.searchBarViewActive = true
                })
            })
        }
    }
}

