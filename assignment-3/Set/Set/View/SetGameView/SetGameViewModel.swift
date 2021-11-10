//
//  SetGameViewModel.swift
//  Set
//
//  Created by Tiago Lopes on 11/10/21.
//

import Foundation
import Combine

final class SetGameViewModel: ObservableObject {
    
    // MARK: Properties
    
    @Published
    private var game = SetGame(deck: Deck())
    
    var cards: [SetCardViewModel] {
        game.tableCards
            .map(SetCardViewModel.init)
    }
    
    var canDeal: Bool {
        game.canDeal
    }
    
    // MARK: Imperatives
    
    func startNewGame() {
        game = SetGame(deck: Deck())
    }
    
    func choose(_ card: SetCardViewModel) {
        guard let index = game.tableCards.firstIndex(where: { $0.id == card.id }) else {
            return
        }
        game.chooseCard(atIndex: index)
    }
    
    func deal() {
        game.deal()
    }
}
