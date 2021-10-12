//
//  CardViewModel.swift
//  Set
//
//  Created by Tiago Lopes on 11/10/21.
//

import Foundation

struct CardViewModel {
    
    // MARK: Properties
    
    let isSelected: Bool
    let isMatched: Bool
    
    // TODO: Declare the features once we have the game being generic.
    
    // MARK: Initializer
    
    init(_ card: Card) {
        isSelected = card.isSelected
        isMatched = card.isMatched
    }
}
