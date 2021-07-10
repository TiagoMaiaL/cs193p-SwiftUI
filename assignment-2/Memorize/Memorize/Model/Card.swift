//
//  Card.swift
//  Memorize
//
//  Created by Tiago Lopes on 01/07/21.
//

import Foundation

struct Card<Content> where Content: Equatable {
    
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
    }
}
