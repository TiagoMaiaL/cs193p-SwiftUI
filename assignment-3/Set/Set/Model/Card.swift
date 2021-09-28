//
//  Card.swift
//  Set
//
//  Created by Tiago Lopes on 23/09/21.
//

import Foundation

// MARK: - Card

extension SetGame {
    struct Card {
        
        // MARK: Properties
        
        var isFaceUp = false
        var isMatched = false
        
        let color: ColorFeature
        let shape: ShapeFeature
        let count: CountFeature
        let shading: ShadingFeature
        
        // MARK: Initializer
        
        init(
            color: ColorFeature,
            shape: ShapeFeature,
            count: CountFeature,
            shading: ShadingFeature
        ) {
            self.color = color
            self.shape = shape
            self.count = count
            self.shading = shading
        }
    }
}

// MARK: - Card Feature

extension SetGame.Card {
    enum ColorFeature: CaseIterable {
        case first
        case second
        case third
    }
    
    enum ShapeFeature: CaseIterable {
        case first
        case second
        case third
    }
    
    enum CountFeature: CaseIterable {
        case one
        case two
        case three
    }
    
    enum ShadingFeature: CaseIterable {
        case first
        case second
        case third
    }
}

// MARK: - Hashable & Equatable

extension SetGame.Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(shape)
        hasher.combine(count)
        hasher.combine(shading)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (
            lhs.color == rhs.color &&
            lhs.shape == rhs.shape &&
            lhs.count == rhs.count &&
            lhs.shading == rhs.shading
        )
    }
}