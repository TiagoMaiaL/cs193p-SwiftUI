//
//  EmojiMemorizeViewModel.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation

final class EmojiMemorizeViewModel {
    
    // MARK: Properties
    
    private var theme: Theme<Emoji>
    private var game: Memorize<Emoji>
    
    var themeName: String { theme.name }
    var themeColor: Theme<Emoji>.Color { theme.color }
    var cards: [EmojiCardViewModel] {
        game.cards.map(EmojiCardViewModel.init)
    }
    
    // MARK: Initializers
    
    init() {
        theme = EmojiThemes.random
        game = Memorize(theme: theme)
    }
    
    // MARK: Imperatives
    
    // Add a method for choosing a card.
    // Add a method for starting a new game.
}
