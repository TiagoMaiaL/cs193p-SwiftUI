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
    enum ColorFeature {
        case first
        case second
        case third
    }
    
    enum ShapeFeature {
        case first
        case second
        case third
    }
    
    enum CountFeature {
        case first
        case second
        case third
    }
    
    enum ShadingFeature {
        case first
        case second
        case third
    }
}
