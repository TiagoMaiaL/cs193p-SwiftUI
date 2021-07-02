//
//  Memorize.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import Foundation

struct Memorize<Content> {
    
    // MARK: Properties
    
    var cards: [Card<Content>]
    var isFinished: Bool { false }
    
    // MARK: Initializer
    
    init(pairsCount: Int, contentProvider: (Int) -> Content) {
        var cards = [Card<Content>]()
        
        for index in 0 ..< pairsCount {
            let pair = [
                Card<Content>(content: contentProvider(index)),
                Card<Content>(content: contentProvider(index))
            ]
            cards.append(contentsOf: pair)
        }
        
        self.cards = cards.shuffled()
    }
    
    // MARK: Imperatives
    
    mutating func chooseCard(atIndex index: Int) {
        cards[index].isFaceUp.toggle()
    }
    
    // MARK: Internal Methods
    
    // TODO: Add code to perform matches.
}
