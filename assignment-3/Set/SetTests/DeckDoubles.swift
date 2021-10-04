//
//  MatchingDeck.swift
//  SetTests
//
//  Created by Tiago Lopes on 02/10/21.
//

import Foundation
@testable import Set

struct MatchingDeck: Deck {
    
    // MARK: Properties
    
    var _cards: Set<SetGame.Card>
    
    // MARK: Initializer
    
    init() {
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .first, shape: .second, count: .one, shading: .first)
        let third = SetGame.Card(color: .first, shape: .third, count: .one, shading: .first)
        
        _cards = Set(arrayLiteral: first, second, third)
    }
}

struct NonMatchingDeck: Deck {
    
    // MARK: Properties
    
    var _cards: Set<SetGame.Card>
    
    // MARK: Initializer
    
    init() {
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = SetGame.Card(color: .third, shape: .third, count: .one, shading: .first)
        
        _cards = Set(arrayLiteral: first, second, third)
    }
}
