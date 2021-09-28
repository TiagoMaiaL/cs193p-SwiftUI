//
//  SetGame.swift
//  Set
//
//  Created by Tiago Lopes on 23/09/21.
//

import Foundation

struct SetGame {
    
    // MARK: Properties
    
    private var deck: Deck
    private(set) var tableCards = [Card]()
    private var matchedCards = Set<Card>()
    
    // MARK: Initializer
    
    init(deck: Deck) {
        self.deck = deck
        let initialCards = self.deck.deal(amount: Constants.initialCardsAmount)
        tableCards.append(contentsOf: initialCards)
    }
    
    // TODO: Add a method to choose a card.
    // TODO: Add a method to check for a match.
    // TODO: Add a method to start a new game.
    // TODO: Add a property to check if the game is finished.
    
    // TODO: Decide if we need to make the cards content generic.
}

// MARK: - Dealing

extension SetGame {
    mutating func deal() {
        let cards = deck.deal()
        tableCards.append(contentsOf: cards)
    }
}

// MARK: - Constants

private extension SetGame {
    enum Constants {
        static let initialCardsAmount = 12
    }
}
