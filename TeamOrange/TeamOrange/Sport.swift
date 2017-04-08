////
////  Sport.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation

enum Sport: String {
    
    static let allSports:[Sport] = [.baseball, .basketball, .volleyball, .tennis, .handball, .pingPong, .bowling, .flagFootball, .soccer, .iceHockey, .fieldHockeygit]
    
    case baseball = "Baseball"
    case basketball = "Basketball"
    case volleyball = "Volleyball"
    case tennis = "Tennis"
    case handball = "Handball"
    case pingPong = "Ping Pong"
    case bowling = "Bowling"
    case flagFootball = "Flag Football"
    case soccer = "Soccer"
    case iceHockey = "Ice Hockey"
    case fieldHockey = "Field Hockey"
    
    var emoji: String {
        switch self {
        case .baseball: return "⚾️"
        case .basketball: return "🏀"
        case .volleyball: return "🏐"
        case .tennis: return "🎾"
        case .handball: return "🖐"
        case .pingPong: return "🏓"
        case .iceHockey: return "🏒"
        case .fieldHockey: return "🏑"
        case .bowling: return "🎳"
        case .flagFootball: return"🏈"
        case .soccer: return "⚽"
        }
    }
    
}


////Syntax for initializing an enum by raw value:
////      mySport = Sport(rawValue: myString)
