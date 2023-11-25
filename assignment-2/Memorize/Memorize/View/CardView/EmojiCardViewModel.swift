//
//  EmojiCardViewModel.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation

struct EmojiCardViewModel: Identifiable, Equatable {
    
    // MARK: Properties
    
    private let card: Memorize<Emoji>.Card
    
    var id: String { card.id }
    var content: String { card.content }
    var isFaceUp: Bool { card.isFaceUp }
    var isMatched: Bool { card.isMatched }
    
    // MARK: Initializer
    
    init(card: Memorize<Emoji>.Card) {
        self.card = card
    }
}
