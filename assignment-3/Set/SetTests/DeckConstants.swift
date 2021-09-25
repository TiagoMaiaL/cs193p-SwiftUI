//
//  DeckConstants.swift
//  SetTests
//
//  Created by Tiago Lopes on 25/09/21.
//

import Foundation
@testable import Set

enum DeckConstants {
    /// The hard-coded cards of a SetGame.
    ///
    /// Used only for testing the deck creation algorithm.
    static let cards = Set([
        // =============
        //
        // ------------
        // ColorFeature: .first
        // ------------
        //
        // ------------
        // ShapeFeature: .first
        // ------------
        //
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .first, count: .one, shading: .first),
        SetGame.Card(color: .first, shape: .first, count: .one, shading: .second),
        SetGame.Card(color: .first, shape: .first, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .first, count: .two, shading: .first),
        SetGame.Card(color: .first, shape: .first, count: .two, shading: .second),
        SetGame.Card(color: .first, shape: .first, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .first, count: .three, shading: .first),
        SetGame.Card(color: .first, shape: .first, count: .three, shading: .second),
        SetGame.Card(color: .first, shape: .first, count: .three, shading: .third),
        
        // ------------
        // ShapeFeature: .second
        // ------------
        
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .second, count: .one, shading: .first),
        SetGame.Card(color: .first, shape: .second, count: .one, shading: .second),
        SetGame.Card(color: .first, shape: .second, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .second, count: .two, shading: .first),
        SetGame.Card(color: .first, shape: .second, count: .two, shading: .second),
        SetGame.Card(color: .first, shape: .second, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .second, count: .three, shading: .first),
        SetGame.Card(color: .first, shape: .second, count: .three, shading: .second),
        SetGame.Card(color: .first, shape: .second, count: .three, shading: .third),
        
        // ------------
        // ShapeFeature: .third
        // ------------
        
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .third, count: .one, shading: .first),
        SetGame.Card(color: .first, shape: .third, count: .one, shading: .second),
        SetGame.Card(color: .first, shape: .third, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .third, count: .two, shading: .first),
        SetGame.Card(color: .first, shape: .third, count: .two, shading: .second),
        SetGame.Card(color: .first, shape: .third, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .first, shape: .third, count: .three, shading: .first),
        SetGame.Card(color: .first, shape: .third, count: .three, shading: .second),
        SetGame.Card(color: .first, shape: .third, count: .three, shading: .third),
        
        // =============
        //
        // ------------
        // ColorFeature: .second
        // ------------
        //
        // ------------
        // ShapeFeature: .first
        // ------------
        //
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .first, count: .one, shading: .first),
        SetGame.Card(color: .second, shape: .first, count: .one, shading: .second),
        SetGame.Card(color: .second, shape: .first, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .first, count: .two, shading: .first),
        SetGame.Card(color: .second, shape: .first, count: .two, shading: .second),
        SetGame.Card(color: .second, shape: .first, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .first, count: .three, shading: .first),
        SetGame.Card(color: .second, shape: .first, count: .three, shading: .second),
        SetGame.Card(color: .second, shape: .first, count: .three, shading: .third),
        
        // ------------
        // ShapeFeature: .second
        // ------------
        
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .second, count: .one, shading: .first),
        SetGame.Card(color: .second, shape: .second, count: .one, shading: .second),
        SetGame.Card(color: .second, shape: .second, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .second, count: .two, shading: .first),
        SetGame.Card(color: .second, shape: .second, count: .two, shading: .second),
        SetGame.Card(color: .second, shape: .second, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .second, count: .three, shading: .first),
        SetGame.Card(color: .second, shape: .second, count: .three, shading: .second),
        SetGame.Card(color: .second, shape: .second, count: .three, shading: .third),
        
        // ------------
        // ShapeFeature: .third
        // ------------
        
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .third, count: .one, shading: .first),
        SetGame.Card(color: .second, shape: .third, count: .one, shading: .second),
        SetGame.Card(color: .second, shape: .third, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .third, count: .two, shading: .first),
        SetGame.Card(color: .second, shape: .third, count: .two, shading: .second),
        SetGame.Card(color: .second, shape: .third, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .second, shape: .third, count: .three, shading: .first),
        SetGame.Card(color: .second, shape: .third, count: .three, shading: .second),
        SetGame.Card(color: .second, shape: .third, count: .three, shading: .third),

        // =============
        //
        // ------------
        // ColorFeature: .third
        // ------------
        //
        // ------------
        // ShapeFeature: .first
        // ------------
        //
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .first, count: .one, shading: .first),
        SetGame.Card(color: .third, shape: .first, count: .one, shading: .second),
        SetGame.Card(color: .third, shape: .first, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .first, count: .two, shading: .first),
        SetGame.Card(color: .third, shape: .first, count: .two, shading: .second),
        SetGame.Card(color: .third, shape: .first, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .first, count: .three, shading: .first),
        SetGame.Card(color: .third, shape: .first, count: .three, shading: .second),
        SetGame.Card(color: .third, shape: .first, count: .three, shading: .third),
        
        // ------------
        // ShapeFeature: .second
        // ------------
        
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .second, count: .one, shading: .first),
        SetGame.Card(color: .third, shape: .second, count: .one, shading: .second),
        SetGame.Card(color: .third, shape: .second, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .second, count: .two, shading: .first),
        SetGame.Card(color: .third, shape: .second, count: .two, shading: .second),
        SetGame.Card(color: .third, shape: .second, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .second, count: .three, shading: .first),
        SetGame.Card(color: .third, shape: .second, count: .three, shading: .second),
        SetGame.Card(color: .third, shape: .second, count: .three, shading: .third),
        
        // ------------
        // ShapeFeature: .third
        // ------------
        
        // CountFeature: .one, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .third, count: .one, shading: .first),
        SetGame.Card(color: .third, shape: .third, count: .one, shading: .second),
        SetGame.Card(color: .third, shape: .third, count: .one, shading: .third),
        
        // CountFeature: .two, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .third, count: .two, shading: .first),
        SetGame.Card(color: .third, shape: .third, count: .two, shading: .second),
        SetGame.Card(color: .third, shape: .third, count: .two, shading: .third),
        
        // CountFeature: .three, ShadingFeature: all
        
        SetGame.Card(color: .third, shape: .third, count: .three, shading: .first),
        SetGame.Card(color: .third, shape: .third, count: .three, shading: .second),
        SetGame.Card(color: .third, shape: .third, count: .three, shading: .third)
    ])
}
