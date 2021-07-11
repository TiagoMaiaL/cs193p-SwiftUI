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
    // TODO: Only provide EmojiCardViewModel instances.
    var cards: [Card<Emoji>] { game.cards }
    
    // MARK: Initializers
    
    init() {
        theme = EmojiThemes.random
        game = Memorize(theme: theme)
    }
    
    // MARK: Imperatives
    
    // Inform the current available cards in the game.
    // Add a method for choosing a card.
    // Add a method for starting a new game.
}
