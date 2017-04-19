//
//  GamePeekScrollerDelegate.swift
//  TeamOrange
//
//  Created by William Brancato on 4/14/17.
//  Copyright © 2017 William Brancato. All rights reserved.
//

import Foundation

protocol GamePeekScrollerDelegate: UICollectionViewDelegate, UICollectionViewDataSource {
    
    var location: Location! { get set }
    var games: [Game] { get set }
    
}
