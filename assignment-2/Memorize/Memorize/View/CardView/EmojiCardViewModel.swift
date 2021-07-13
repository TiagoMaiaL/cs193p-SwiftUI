//
//  EmojiCardViewModel.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation

struct EmojiCardViewModel {
    
    // MARK: Properties
    
    private let card: Card<Emoji>
    
    var id: String { card.id }
    var content: String { card.content }
    var isFaceUp: Bool { card.isFaceUp }
    var isMatched: Bool { card.isMatched }
    
    // MARK: Initializer
    
    init(card: Card<Emoji>) {
        self.card = card
    }
}

extension EmojiCardViewModel: Identifiable {}
