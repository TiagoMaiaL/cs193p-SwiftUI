//
//  SetGame.swift
//  Set
//
//  Created by Tiago Lopes on 23/09/21.
//

import Foundation

struct SetGame<Deck: SetDeck> {
    
    // MARK: Properties
    
    private var deck: Deck
    private(set) var tableCards = [Deck.Card]()
    private(set) var matchedCards = Set<Deck.Card>()
    
    // MARK: Initializer
    
    init(deck: Deck) {
        self.deck = deck
        let initialCards = self.deck.deal(amount: Constants.initialCardsAmount)
        tableCards.append(contentsOf: initialCards)
    }
    // TODO: Add a property to check if the game is finished.
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
    private var selectedTrio: SetTrio<Deck.Card>? {
        get {
            let selectedCards = tableCards.filter { $0.isSelected }
            
            guard selectedCards.count == 3 else {
                return nil
            }
            
            return SetTrio(first: selectedCards[0],
                           second: selectedCards[1],
                           third: selectedCards[2])
        }
        set {
            tableCards
                .filter(\.isSelected)
                .compactMap(tableCards.firstIndex(of:))
                .forEach { tableCards[$0].isSelected = false }
        }
    }
    
    mutating func chooseCard(atIndex index: Int) {
        guard index < tableCards.count else {
            assertionFailure("Selecting an out of bounds card.")
            return
        }
        
        if let trio = selectedTrio {
            if trio.isSet {
                tableCards[index].isSelected = true
                removeMatchedCardsFromTable()
                deal()
            } else {
                selectedTrio = nil
                tableCards[index].isSelected = true
            }
            
        } else {
            tableCards[index].isSelected.toggle()
            performMatchIfNeeded()
        }
    }
}

// MARK: - Matching

private extension SetGame {
    mutating func performMatchIfNeeded() {
        if let trio = selectedTrio, trio.isSet {
            trio.cards
                .compactMap { tableCards.firstIndex(of: $0 ) }
                .forEach { tableCards[$0].isMatched = true }
        }
    }
    
    mutating func removeMatchedCardsFromTable() {
        tableCards
            .filter { $0.isMatched }
            .forEach { matchedCards.insert($0) }
        
        tableCards.removeAll(where: { $0.isMatched })
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let initialCardsAmount = 12
}
