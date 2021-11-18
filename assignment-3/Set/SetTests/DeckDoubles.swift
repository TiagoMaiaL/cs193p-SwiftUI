//
//  MatchingDeck.swift
//  SetTests
//
//  Created by Tiago Lopes on 02/10/21.
//

import Foundation
@testable import Set

// MARK: - MatchingDeck

final class MatchingDeck: SetDeck {
    
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

// MARK: - NonMatchingDeck

final class NonMatchingDeck: SetDeck {
    
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

// MARK: - VacantDealingDeck

final class VacantDealingDeck: SetDeck {
    // MARK: Properties
    
    var _cards: Set<Card>
    
    let firstMatchingTrio = [
        Card(color: .first, shape: .first, count: .one, shading: .first),
        Card(color: .first, shape: .second, count: .one, shading: .first),
        Card(color: .first, shape: .third, count: .one, shading: .first)
    ]
    let secondMatchingTrio = [
        Card(color: .second, shape: .first, count: .one, shading: .first),
        Card(color: .second, shape: .second, count: .one, shading: .first),
        Card(color: .second, shape: .third, count: .one, shading: .first)
    ]
    let nonMatchingTrio = [
        Card(color: .third, shape: .first, count: .one, shading: .first),
        Card(color: .third, shape: .second, count: .one, shading: .second),
        Card(color: .third, shape: .third, count: .one, shading: .second)
    ]
    
    // MARK: Initializer
    
    init() {
        _cards = Set(firstMatchingTrio + secondMatchingTrio)
    }
    
    // MARK: Imperatives
    
    func addNonMatchingTrio() {
        nonMatchingTrio.forEach {
            _cards.insert($0)
        }
    }
}
