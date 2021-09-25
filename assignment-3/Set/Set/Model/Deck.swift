//
//  Deck.swift
//  Set
//
//  Created by Tiago Lopes on 24/09/21.
//

import Foundation

extension SetGame {
    struct Deck {
        // MARK: Properties
        
        private(set) var cards: Set<SetGame.Card>
        
        // MARK: Initializer
        
        init() {
            cards = Set(Deck.makeCards())
        }
    }
}

// MARK: - Cards generation

private extension SetGame.Deck {
    typealias Card = SetGame.Card
    typealias ColorFeature = SetGame.Card.ColorFeature
    typealias ShapeFeature = SetGame.Card.ShapeFeature
    typealias CountFeature = SetGame.Card.CountFeature
    typealias ShadingFeature = SetGame.Card.ShadingFeature
    
    private static func makeCards() -> [Card] {
        ColorFeature
            .allCases
            .flatMap { makeCards(color: $0) }
            .shuffled()
    }
    
    private static func makeCards(color: ColorFeature) -> [Card] {
        ShapeFeature
            .allCases
            .flatMap { makeCards(color: color, shape: $0) }
    }
    
    private static func makeCards(
        color: ColorFeature,
        shape: ShapeFeature
    ) -> [Card] {
        CountFeature
            .allCases
            .flatMap { makeCards(color: color, shape: shape, count: $0) }
    }
    
    private static func makeCards(
        color: ColorFeature,
        shape: ShapeFeature,
        count: CountFeature
    ) -> [Card] {
        ShadingFeature
            .allCases
            .map { Card(color: color, shape: shape, count: count, shading: $0) }
    }
}
