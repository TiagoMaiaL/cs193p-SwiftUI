//
//  EmojiMemorizeViewModel.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation
import SwiftUI
import Combine

final class EmojiMemorizeViewModel: ObservableObject {
    
    // MARK: Properties
    
    private var theme: Theme<Emoji>
    
    @Published
    private var game: Memorize<Emoji>
    
    var themeName: String { theme.name }
    var themeColor: Color { theme.color.userInterfaceColor }
    var cards: [EmojiCardViewModel] {
        game.cards.map(EmojiCardViewModel.init)
    }
    var score: Int {
        game.score
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
