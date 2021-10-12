//
//  SetGameViewModel.swift
//  Set
//
//  Created by Tiago Lopes on 11/10/21.
//

import Foundation

final class SetGameViewModel {
    
    // MARK: Properties
    
    private lazy var game = SetGame(deck: FullDeck())
    
    // TODO: Add a method to start a new game.
    // TODO: Add the cards property, which will return an array of cardViewModels.
    
    // MARK: Imperatives
    
    func startNewGame() {
        game = SetGame(deck: FullDeck())
    }
    
    // TODO: Add a method to choose a card.
    
    func deal() {
        game.deal()
    }
}
