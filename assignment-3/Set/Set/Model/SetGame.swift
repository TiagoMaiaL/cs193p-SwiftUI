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
    
    // TODO: Add a method to start a new game. Add this to the view model.
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

// MARK: - Choosing Cards

extension SetGame {
    // TODO: Refactor -> create a proper Trio type.
    private var selectedTrio: (first: Card, second: Card, third: Card)? {
        let selectedCards = tableCards.filter { $0.isSelected }
        
        guard selectedCards.count == 3 else {
            return nil
        }
        
        return (first: selectedCards[0],
                second: selectedCards[1],
                third: selectedCards[2])
    }
    
    mutating func chooseCard(atIndex index: Int) {
        guard index < tableCards.count else {
            assertionFailure("Selecting an out of bounds card.")
            return
        }
        
        if let trio = selectedTrio {
            guard tableCards[index] != trio.first,
                  tableCards[index] != trio.second,
                  tableCards[index] != trio.third else {
                      return
                  }
            
            // TODO: Select the new card.
            // TODO: Check if the trio is a Set or not.
            
        } else {
            tableCards[index].isSelected.toggle()
        }
    }
}

// MARK: - Constants

private extension SetGame {
    enum Constants {
        static let initialCardsAmount = 12
    }
}
