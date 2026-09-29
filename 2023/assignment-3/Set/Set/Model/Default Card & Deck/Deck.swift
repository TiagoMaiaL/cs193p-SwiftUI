//
//  Deck.swift
//  Set
//
//  Created by Tiago Lopes on 24/09/21.
//

import Foundation

// MARK: - Deck

struct Deck: SetDeck {
    
    // MARK: Properties
    
    var _cards: Set<Card>
    
    // MARK: Initializer
    
    init() {
        _cards = Set(Deck.makeCards())
    }
}
