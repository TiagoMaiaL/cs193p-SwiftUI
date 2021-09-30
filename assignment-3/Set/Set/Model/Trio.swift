//
//  Trio.swift
//  Set
//
//  Created by Tiago Lopes on 29/09/21.
//

import Foundation

extension SetGame {
    struct Trio {
        
        // MARK: Properties
        
        private let first: Card
        private let second: Card
        private let third: Card
        
        // MARK: Initializer
        
        init?(first: Card, second: Card, third: Card) {
            let cards = Set([first, second, third])
            
            guard cards.count == 3 else {
                return nil
            }
            
            self.first = first
            self.second = second
            self.third = third
        }
    }
}

// MARK: - Public Methods

extension SetGame.Trio {
    func contains(_ card: SetGame.Card) -> Bool {
        card == first || card == second || card == third
    }
}
