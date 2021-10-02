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
    
    var cards: Set<SetGame.Card>
    
    init() {
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .first, shape: .second, count: .one, shading: .first)
        let third = SetGame.Card(color: .first, shape: .third, count: .one, shading: .first)
        
        cards = Set(arrayLiteral: first, second, third)
    }
    
    mutating func deal(amount: Int) -> [SetGame.Card] {
        []
    }
    
    mutating func deal() -> [SetGame.Card] {
        deal(amount: 3)
    }
}
