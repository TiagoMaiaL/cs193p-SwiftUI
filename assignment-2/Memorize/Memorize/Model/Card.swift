//
//  Card.swift
//  Memorize
//
//  Created by Tiago Lopes on 01/07/21.
//

import Foundation

// MARK: - Card

extension Memorize {
    struct Card: Identifiable {
        let id: String = UUID().uuidString
        let content: Content
        var isFaceUp = false
        var isMatched = false
    }
}
