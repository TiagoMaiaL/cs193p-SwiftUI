//
//  Card.swift
//  Memorize
//
//  Created by Tiago Lopes on 01/07/21.
//

import Foundation

struct Card<Content> where Content: Hashable {
    
    // MARK: Properties
    
    let id = UUID().uuidString
    let content: Content
    var isFaceUp = false
    var isMatched = false
}

// MARK: - Hashable

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(content)
    }
    
    static func == (lhs: Card, rhs: Card) -> Bool {
        return lhs.id == rhs.id && lhs.content == rhs.content
    }
}
