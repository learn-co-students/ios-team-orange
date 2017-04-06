////
////  Sport.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation

enum Sport: String {
    
    static let allSports:[Sport] = [.baseball, .basketball]
    
    case baseball = "baseball"
    case basketball = "handball"
    
}


////Syntax for initializing an enum by raw value:
////      mySport = Sport(rawValue: myString)
