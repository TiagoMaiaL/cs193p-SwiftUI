//
//  EmojiThemes.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation

enum EmojiThemes {
    
    // MARK: Themes
    
    static let nature = Theme(
        name: "Nature",
        pairsCount: 6,
        options: ["🌳", "🌲", "🌵", "🌴", "⛰", "🗻"],
        color: .green
    )
    
    static let flags = Theme(
        name: "Flags",
        pairsCount: 10,
        options: ["🇧🇷", "🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇿🇦", "🇲🇽", "🇯🇵", "🇵🇹", "🇩🇪", "🇵🇱", "🇦🇹", "🇮🇹", "🇫🇷", "🇦🇷", "🇨🇱"],
        color: .gray
    )
    
    static let faces = Theme(
        name: "Faces",
        pairsCount: 6,
        options: ["😀", "😃", "😂", "🥲", "😎", "🧐"],
        color: .yellow
    )
    
    static let halloween = Theme(
        name: "Halloween",
        pairsCount: 6,
        options: ["🎃", "👻", "💀", "🦇", "🌕", "🐺"],
        color: .purple
    )
    
    static let vehicles = Theme(
        name: "Vehicles",
        pairsCount: 7,
        options: ["🚔", "🚗", "🚒", "🚚", "🚌", "🛻", "🚛", "🚑", "🚜"],
        color: .blue
    )
    
    static let food = Theme(
        name: "Food",
        pairsCount: 6,
        options: ["🌭", "🌶", "🍔", "🍟", "🍏", "🍇"],
        color: .red
    )
    
    static var allThemes: [Theme<Emoji>] {
        [nature, flags, faces, halloween, vehicles, food]
    }
    
    // MARK: Random
    
    static var random: Theme<Emoji> {
        allThemes.randomElement()!
    }
    
    static func random(excluding themeToExclude: Theme<Emoji>) -> Theme<Emoji> {
        var themes = allThemes
        
        guard let removalIndex = allThemes.firstIndex(where: { $0.name == themeToExclude.name }) else {
            return random
        }
        
        themes.remove(at: removalIndex)
        
        return themes.randomElement()!
    }
}
