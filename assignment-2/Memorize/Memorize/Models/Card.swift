//
//  Card.swift
//  Memorize
//
//  Created by Tiago Lopes on 01/07/21.
//

import Foundation

struct Card<Content> {
    
    // MARK: Properties
    
    let content: Content
    var isFaceUp = false
    var isMatched = false
}
