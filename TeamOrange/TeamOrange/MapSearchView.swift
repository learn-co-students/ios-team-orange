//
//  MapViewController.swift
//  TeamOrange
//
//  Created by Edmund Holderbaum on 4/4/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import UIKit
import MapKit

class mapSearchView: UIView {
    /*
            IMPORTANT!!!!!
    assign mapView to weak var mapView! in VC and adopt MapUpdater protocol!
    */
    lazy var mapView = MKMapView()
    
    lazy var searchButton = UIButton()

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
        searchButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
        searchButton.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        searchButton.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.077).isActive = true
        searchButton.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.14).isActive = true
        searchButton.layer.cornerRadius = 29
        searchButton.setTitle("-O", for: .normal)
        self.insertSubview(searchButton, aboveSubview: mapView)
    }
}
