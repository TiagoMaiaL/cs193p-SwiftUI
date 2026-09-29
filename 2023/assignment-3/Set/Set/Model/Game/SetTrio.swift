//
//  SetTrio.swift
//  Set
//
//  Created by Tiago Lopes on 29/09/21.
//

import Foundation

struct SetTrio<CardType: SetCard> {
    
    // MARK: Properties
    
    private let first: CardType
    private let second: CardType
    private let third: CardType
    let isSet: Bool
    var cards: [CardType] {
        [first, second, third]
    }
    
    // MARK: Initializer
    
    init?(first: CardType, second: CardType, third: CardType) {
        let cards = Set([first, second, third])
        
        guard cards.count == 3 else {
            return nil
        }
        
        self.first = first
        self.second = second
        self.third = third
        self.isSet = SetTrio.checkIfCardsMatch(
            first: first,
            second: second,
            third: third
        )
    }
}

// MARK: - Contains

extension SetTrio {
    func contains(_ card: CardType) -> Bool {
        card == first || card == second || card == third
    }
}

// MARK: - Matching

private extension SetTrio {
    static func checkIfCardsMatch(
        first: CardType,
        second: CardType,
        third: CardType
    ) -> Bool {
        (
            (first.firstFeature == second.firstFeature && second.firstFeature == third.firstFeature) ||
            (first.firstFeature != second.firstFeature && second.firstFeature != third.firstFeature && first.firstFeature != third.firstFeature)
        ) && (
            (first.secondFeature == second.secondFeature && second.secondFeature == third.secondFeature) ||
            (first.secondFeature != second.secondFeature && second.secondFeature != third.secondFeature && first.secondFeature != third.secondFeature)
        ) && (
            (first.thirdFeature == second.thirdFeature && second.thirdFeature == third.thirdFeature) ||
            (first.thirdFeature != second.thirdFeature && second.thirdFeature != third.thirdFeature && first.thirdFeature != third.thirdFeature)
        ) && (
            (first.fourthFeature == second.fourthFeature && second.fourthFeature == third.fourthFeature) ||
            (first.fourthFeature != second.fourthFeature && second.fourthFeature != third.fourthFeature && first.fourthFeature != third.fourthFeature)
        )
    }
}
