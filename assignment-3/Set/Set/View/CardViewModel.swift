//
//  CardViewModel.swift
//  Set
//
//  Created by Tiago Lopes on 11/10/21.
//

import Foundation
import struct SwiftUI.Color

struct CardViewModel {
    
    // MARK: Properties
    
    private let card: Card
    
    var isSelected: Bool { card.isSelected }
    var isMatched: Bool { card.isMatched }
    
//    let color: Color {
//        switch card.color {
//        case .first:
//            return .blue
//
//        case .second:
//            return .red
//
//        case .third:
//            return .green
//        }
//    }
//
//    let count: Int {
//
//    }
//
    // TODO: Declare the features once we have the game being generic.
    
    // MARK: Initializer
    
    init(_ card: Card) {
        self.card = card
    }
}
