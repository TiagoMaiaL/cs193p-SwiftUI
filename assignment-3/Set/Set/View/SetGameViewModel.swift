//
//  SetGameViewModel.swift
//  Set
//
//  Created by Tiago Lopes on 11/10/21.
//

import Foundation

final class SetGameViewModel {
    
    // MARK: Properties
    
    private lazy var game = SetGame(deck: Deck())
    
    var cards: [SetCardViewModel] {
        game.tableCards
            .map(SetCardViewModel.init)
    }
    
    // MARK: Imperatives
    
    func startNewGame() {
        game = SetGame(deck: Deck())
    }
    
    func choose(card: SetCardViewModel) {
        guard let index = game.tableCards.firstIndex(where: { $0.id == card.id }) else {
            return
        }
        game.chooseCard(atIndex: index)
    }
    
    func deal() {
        game.deal()
    }
}
