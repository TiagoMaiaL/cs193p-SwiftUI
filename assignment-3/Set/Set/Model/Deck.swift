//
//  Deck.swift
//  Set
//
//  Created by Tiago Lopes on 24/09/21.
//

import Foundation

// MARK: - Deck Protocol

protocol Deck {
    
    // MARK: Types
    
    associatedtype Card: SetCard
    
    // MARK: Properties
    
    /// The internal cards in a deck.
    /// - Note: Intended to be used internally only. This property is declared here
    ///         to enable the default `deal()` implementations.
    var _cards: Set<Card> { get set }
    var count: Int { get }
    var isEmpty: Bool { get }
    
    // MARK: Methods
    
    mutating func deal(amount: Int) -> [Card]
    mutating func deal() -> [Card]
}

// MARK: - Default

extension Deck {
    var isEmpty: Bool { _cards.isEmpty }
    var count: Int { _cards.count }
}

extension Deck {
    mutating func deal(amount: Int) -> [Card] {
        guard !_cards.isEmpty else {
            return []
        }
        let amount = min(_cards.count, amount)
        
        return (0 ..< amount).map { _ in _cards.removeFirst() }
    }
    
    // Protocols don't allow default arguments. That's why we need an extra method.
    mutating func deal() -> [Card] {
        deal(amount: 3)
    }
}

// MARK: - FullDeck

struct FullDeck: Deck {
    
    // MARK: Properties
    
    var _cards: Set<Card>
    
    // MARK: Initializer
    
    init() {
        _cards = Set(FullDeck.makeCards())
    }
}

// MARK: - Cards generation

private extension FullDeck {
    typealias ColorFeature = Card.ColorFeature
    typealias ShapeFeature = Card.ShapeFeature
    typealias CountFeature = Card.CountFeature
    typealias ShadingFeature = Card.ShadingFeature
    
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
