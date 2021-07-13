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
    
    func choose(_ cardViewModel: EmojiCardViewModel) {
        guard let cardIndex = game.cards.firstIndex(where: { $0.id == cardViewModel.id }) else {
            return
        }
        
        game.chooseCard(atIndex: cardIndex)
    }
    
    func startNewGame() {
        let oldTheme = theme
        theme = EmojiThemes.random(excluding: oldTheme)
        game = Memorize(theme: theme)
    }
}
