//
//  SetDeck.swift
//  Set
//
//  Created by Tiago Lopes on 12/10/21.
//

import Foundation

// MARK: - Deck Protocol

protocol SetDeck {
    
    // MARK: Types
    
    associatedtype Card: SetCard
    
    // MARK: Properties
    
    /// The internal cards in a deck.
    /// - Note: Intended to be used internally only. This property is declared here
    ///         to enable the default `deal()` implementations.
    var _cards: Set<Card> { get set }
    var count: Int { get }
    var isEmpty: Bool { get }
    
    // MARK: Methods
    
    mutating func deal(amount: Int) -> [Card]
    mutating func deal() -> [Card]
}

// MARK: - Default Implementation

extension SetDeck {
    var isEmpty: Bool { _cards.isEmpty }
    var count: Int { _cards.count }
}

extension SetDeck {
    mutating func deal(amount: Int) -> [Card] {
        guard !_cards.isEmpty else {
            return []
        }
        let amount = min(_cards.count, amount)
        
        return (0 ..< amount).map { _ in _cards.removeFirst() }
    }
    
    // Protocols don't allow default arguments. That's why we need an extra method.
    mutating func deal() -> [Card] {
        deal(amount: 3)
    }
}
