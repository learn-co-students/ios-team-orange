////
////  Sport.swift
////  TeamOrange
////
////  Created by William Brancato on 4/3/17.
////  Copyright © 2017 William Brancato. All rights reserved.
////


import Foundation

enum Sport: String {
    
    static let allSports:[Sport] = [.baseball, .basketball, .volleyball, .tennis, .handball, .pingPong, .bowling, .flagFootball, .soccer, .iceHockey, .fieldHockey]
    
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
    
    var image: ClickableImage {
        switch self {
        case .baseball: return ClickableImage(#imageLiteral(resourceName: "football"))
        case .basketball: return ClickableImage(#imageLiteral(resourceName: "basketball"))
        case .volleyball: return ClickableImage(#imageLiteral(resourceName: "volleyball"))
        case .tennis: return ClickableImage(#imageLiteral(resourceName: "tennis"))
        case .handball: return ClickableImage(#imageLiteral(resourceName: "handball"))
        case .pingPong: return ClickableImage(#imageLiteral(resourceName: "pingPong"))
        case .iceHockey: return ClickableImage(#imageLiteral(resourceName: "iceHockey"))
        case .fieldHockey: return ClickableImage(#imageLiteral(resourceName: "fieldHockey"))
        case .bowling: return ClickableImage(#imageLiteral(resourceName: "bowling"))
        case .flagFootball: return ClickableImage(#imageLiteral(resourceName: "flagFootball"))
        case .soccer: return ClickableImage(#imageLiteral(resourceName: "soccer"))
        }
    }
    
}


////Syntax for initializing an enum by raw value:
////      mySport = Sport(rawValue: myString)
