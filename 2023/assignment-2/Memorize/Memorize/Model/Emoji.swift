//
//  Emoji.swift
//  Memorize
//
//  Created by Tiago Lopes on 10/07/21.
//

import Foundation

typealias Emoji = String

enum EmojiThemes {
    
    // MARK: Themes
    
    static let nature = Theme<Emoji>(
        name: "Nature",
        options: ["🌳", "🌲", "🌵", "🌴", "⛰", "🗻"],
        color: .green
    )
    
    static let flags = Theme<Emoji>(
        name: "Flags",
        options: ["🇧🇷", "🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇿🇦", "🇲🇽", "🇯🇵", "🇵🇹", "🇩🇪", "🇵🇱", "🇦🇹", "🇮🇹", "🇫🇷", "🇦🇷", "🇨🇱"],
        color: .gray,
        maxRandomPairs: 12
    )
    
    static let faces = Theme<Emoji>(
        name: "Faces",
        options: ["😀", "😃", "😂", "🥲", "😎", "🧐"],
        color: .yellow
    )
    
    static let halloween = Theme<Emoji>(
        name: "Halloween",
        options: ["🎃", "👻", "💀", "🦇", "🌕", "🐺"],
        color: .purple
    )
    
    static let vehicles = Theme<Emoji>(
        name: "Vehicles",
        pairsCount: 7,
        options: ["🚔", "🚗", "🚒", "🚚", "🚌", "🛻", "🚛", "🚑", "🚜"],
        color: .blue
    )
    
    static let food = Theme<Emoji>(
        name: "Food",
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
        
        guard !themes.isEmpty else {
            preconditionFailure("allThemes array should never be empty.")
        }
        
        guard let removalIndex = themes.firstIndex(where: { $0.name == themeToExclude.name }) else {
            return random
        }
        
        themes.remove(at: removalIndex)
        
        guard let randomTheme = themes.randomElement() else {
            preconditionFailure("A random theme should always be picked, the themes array should never be empty.")
        }
        
        return randomTheme
    }
}
