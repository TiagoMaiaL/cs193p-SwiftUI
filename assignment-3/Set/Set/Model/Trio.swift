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
        let isSet: Bool
        
        // MARK: Initializer
        
        init?(first: Card, second: Card, third: Card) {
            let cards = Set([first, second, third])
            
            guard cards.count == 3 else {
                return nil
            }
            
            self.first = first
            self.second = second
            self.third = third
            self.isSet = Trio.checkIfCardsMatch(
                first: first,
                second: second,
                third: third
            )
        }
    }
}

// MARK: - Contains

extension SetGame.Trio {
    func contains(_ card: SetGame.Card) -> Bool {
        card == first || card == second || card == third
    }
}

// MARK: - Matching

private extension SetGame.Trio {
    static func checkIfCardsMatch(
        first: SetGame.Card,
        second: SetGame.Card,
        third: SetGame.Card
    ) -> Bool {
        (
            (first.color == second.color && second.color == third.color) ||
            (first.color != second.color && second.color != third.color && first.color != third.color)
        ) && (
            (first.shape == second.shape && second.shape == third.shape) ||
            (first.shape != second.shape && second.shape != third.shape && first.shape != third.shape)
        ) && (
            (first.count == second.count && second.count == third.count) ||
            (first.count != second.count && second.count != third.count && first.count != third.count)
        ) && (
            (first.shading == second.shading && second.shading == third.shading) ||
            (first.shading != second.shading && second.shading != third.shading && first.shading != third.shading)
        )
    }
}
