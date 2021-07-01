//
//  Memorize.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import Foundation

struct Memorize<Content> {
    
    // TODO: Write unit tests for this model.
    
    // MARK: Properties
    
    var cards: [Content]
    var isFinished: Bool { false }
    
    // MARK: Initializer
    
    init(pairsCount: Int, contentProvider: (Int) -> Content) {
        var cards = [Content]()
        
        for index in 0 ..< pairsCount * 2 {
            let card = contentProvider(index)
            cards.append(card)
        }
        
        self.cards = cards.shuffled()
    }
    
    // MARK: Imperatives
    
    // TODO: Add the method for flipping a card.
}
