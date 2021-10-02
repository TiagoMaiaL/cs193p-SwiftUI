//
//  Deck.swift
//  Set
//
//  Created by Tiago Lopes on 24/09/21.
//

import Foundation

// MARK: - Deck Protocol

protocol DeckProtocol {
    
    // MARK: Properties
    
    var cards: Set<SetGame.Card> { get }
    var isEmpty: Bool { get }
    
    // MARK: Methods
    
    mutating func deal(amount: Int) -> [SetGame.Card]
    mutating func deal() -> [SetGame.Card]
}

extension DeckProtocol {
    var isEmpty: Bool { cards.isEmpty }
}

// MARK: - Deck Implementation

extension SetGame {
    struct Deck: DeckProtocol {
        
        // MARK: Properties
        
        private(set) var cards: Set<SetGame.Card>
        
        // MARK: Initializer
        
        init() {
            cards = Set(Deck.makeCards())
        }
    }
}

extension SetGame.Deck {
    mutating func deal(amount: Int) -> [SetGame.Card] {
        guard !cards.isEmpty else {
            return []
        }
        let amount = min(cards.count, amount)
        
        return (0 ..< amount).map { _ in cards.removeFirst() }
    }
    
    // Protocols don't allow default arguments. That's why we need an extra method.
    mutating func deal() -> [SetGame.Card] {
        deal(amount: 3)
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
