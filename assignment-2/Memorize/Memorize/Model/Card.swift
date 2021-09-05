//
//  Card.swift
//  Memorize
//
//  Created by Tiago Lopes on 01/07/21.
//

import Foundation

// MARK: - Card

extension Memorize {
    struct Card {
        let id = UUID().uuidString
        let content: Content
        var isFaceUp = false
        var isMatched = false
    }
}

// MARK: - Card + Hashable

extension Memorize.Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id && lhs.content == rhs.content
    }
}
