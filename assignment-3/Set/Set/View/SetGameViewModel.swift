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
    
    // TODO: Add a method to choose a card.
    
    func deal() {
        game.deal()
    }
}
