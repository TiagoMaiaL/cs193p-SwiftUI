//
//  FullDeck.swift
//  Set
//
//  Created by Tiago Lopes on 24/09/21.
//

import Foundation

// MARK: - FullDeck

struct FullDeck: SetDeck {
    
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
