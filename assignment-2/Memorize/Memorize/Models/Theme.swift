//
//  Theme.swift
//  Memorize
//
//  Created by Tiago Lopes on 07/07/21.
//

import Foundation

struct Theme<Content> where Content: Equatable {
    
    // MARK: Properties
    
    let name: String
    let pairsCount: Int
    let options: [Content]
    let color: Color
    // TODO: Add and test the shuffled options.
    // TODO: Add custom initialization.
}

// TODO: Make a Memorize extension that accepts a Theme.
// TODO: Add a namespace for Emoji themes.
