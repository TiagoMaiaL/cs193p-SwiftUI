//
//  Emoji.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation

typealias Emoji = String
typealias EmojiMemorize = Memorize<Emoji>
typealias EmojiTheme = Theme<Emoji>

enum EmojiThemes {
    
    // MARK: Themes
    
    static let nature = EmojiTheme(
        name: "Nature",
        options: ["🌳", "🌲", "🌵", "🌴", "⛰", "🗻"],
        color: .green
    )
    
    static let flags = EmojiTheme(
        name: "Flags",
        pairsCount: 10,
        options: ["🇧🇷", "🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇿🇦", "🇲🇽", "🇯🇵", "🇵🇹", "🇩🇪", "🇵🇱", "🇦🇹", "🇮🇹", "🇫🇷", "🇦🇷", "🇨🇱"],
        color: .gray
    )
    
    static let faces = EmojiTheme(
        name: "Faces",
        options: ["😀", "😃", "😂", "🥲", "😎", "🧐"],
        color: .yellow
    )
    
    static let halloween = EmojiTheme(
        name: "Halloween",
        options: ["🎃", "👻", "💀", "🦇", "🌕", "🐺"],
        color: .purple
    )
    
    static let vehicles = EmojiTheme(
        name: "Vehicles",
        pairsCount: 7,
        options: ["🚔", "🚗", "🚒", "🚚", "🚌", "🛻", "🚛", "🚑", "🚜"],
        color: .blue
    )
    
    static let food = EmojiTheme(
        name: "Food",
        options: ["🌭", "🌶", "🍔", "🍟", "🍏", "🍇"],
        color: .red
    )
    
    static var allThemes: [EmojiTheme] {
        [nature, flags, faces, halloween, vehicles, food]
    }
    
    // MARK: Random
    
    static var random: EmojiTheme {
        allThemes.randomElement()!
    }
    
    static func random(excluding themeToExclude: EmojiTheme) -> EmojiTheme {
        var themes = allThemes
        
        guard let removalIndex = themes.firstIndex(where: { $0.name == themeToExclude.name }) else {
            return random
        }
        
        themes.remove(at: removalIndex)
        
        return themes.randomElement()!
    }
}
