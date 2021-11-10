//
//  SetCardViewModel.swift
//  Set
//
//  Created by Tiago Lopes on 11/10/21.
//

import Foundation
import struct SwiftUI.Color

struct SetCardViewModel {
    
    // MARK: Properties
    
    private let card: Card
    
    private var _id: UUID { card.id }
    
    var isSelected: Bool { card.isSelected }
    var isMatched: Bool { card.isMatched }
    
    var color: Color {
        switch card.color {
        case .first:
            return .blue

        case .second:
            return .red

        case .third:
            return .green
        }
    }

    var count: Int {
        switch card.count {
        case .one:
            return 1
            
        case .two:
            return 2
            
        case .three:
            return 3
        }
    }
    
    var shape: Shape {
        switch card.shape {
        case .first:
            return .oval
            
        case .second:
            return .squiggle
            
        case .third:
            return .diamond
        }
    }
    
    var shading: Shading {
        switch card.shading {
        case .first:
            return .solid
            
        case .second:
            return .striped
            
        case .third:
            return .stroked
        }
    }
    
    // MARK: Initializer
    
    init(_ card: Card) {
        self.card = card
    }
}

// TODO: Move the Shape enum to its appropriate file.
enum Shape {
    case oval
    case squiggle
    case diamond
}

extension Shape: CustomStringConvertible {
    var description: String {
        switch self {
        case .oval:
            return "Oval"
            
        case .squiggle:
            return "Squiggle"
            
        case .diamond:
            return "Diamond"
        }
    }
}

// TODO: Move the Shading enum to its appropriate file.
enum Shading {
    case solid
    case striped
    case stroked
}

extension Shading: CustomStringConvertible {
    var description: String {
        switch self {
        case .solid:
            return "Solid"
            
        case .striped:
            return "Striped"
            
        case .stroked:
            return "Stroked"
        }
    }
}

// MARK: - Identifiable

extension SetCardViewModel: Identifiable {
    var id: UUID { _id }
}