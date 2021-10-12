//
//  MatchingDeck.swift
//  SetTests
//
//  Created by Tiago Lopes on 02/10/21.
//

import Foundation
@testable import Set

final class MatchingDeck: Deck {
    
    // MARK: Properties
    
    var _cards: Set<Card>
    
    // MARK: Initializer
    
    init() {
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .first, shape: .second, count: .one, shading: .first)
        let third = Card(color: .first, shape: .third, count: .one, shading: .first)
        
        _cards = Set(arrayLiteral: first, second, third)
    }
    
    // MARK: Imperatives
    
    func insert(_ card: Card) {
        _cards.insert(card)
    }
}

final class NonMatchingDeck: Deck {
    
    // MARK: Properties
    
    var _cards: Set<Card>
    
    // MARK: Initializer
    
    init() {
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = Card(color: .third, shape: .third, count: .one, shading: .first)
        
        _cards = Set(arrayLiteral: first, second, third)
    }
    
    // MARK: Imperatives
    
    func insert(_ card: Card) {
        _cards.insert(card)
    }
}
