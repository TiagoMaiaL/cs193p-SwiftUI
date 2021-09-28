//
//  SetGameTests.swift
//  SetTests
//
//  Created by Tiago Lopes on 26/09/21.
//

import XCTest
@testable import Set

class SetGameTests: XCTestCase {
    
    // MARK: Tests
    
    func testTheGameStartsWithTwelveCardsOnTheTable() {
        // Given
        let initialCardsAmount = 12
        let deck = SetGame.Deck()
        
        // When
        let game = SetGame(deck: deck)
        
        // Then
        XCTAssertEqual(game.tableCards.count, initialCardsAmount)
    }
    
    func testTheGameAllowsMoreCardsToBeDealt() {
        // Given
        let initialCardsAmount = 12
        let dealtCardsCount = 3
        let deck = SetGame.Deck()
        var game = SetGame(deck: deck)
        
        // When
        game.deal()
        
        // Then
        XCTAssertEqual(game.tableCards.count, initialCardsAmount + dealtCardsCount)
    }
}
