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
    
    // MARK: - Initialization
    
    func testItStartsWithTwelveCardsOnTheTable() {
        // Given
        let initialCardsAmount = 12
        let deck = SetGame.Deck()
        
        // When
        let game = SetGame(deck: deck)
        
        // Then
        XCTAssertEqual(game.tableCards.count, initialCardsAmount)
    }
    
    // MARK: - Dealing
    
    func testItAllowsMoreCardsToBeDealt() {
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
    
    // MARK: - Choosing Cards
    
    func testItSelectsACardWhenTheUserChoosesOne() {
        // Given
        let deck = SetGame.Deck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        let card = game.tableCards[0]
        
        // Then
        XCTAssertTrue(card.isSelected)
    }
    
    func testItDeselectsACardWhenTheUserChoosesASelectedOne() {
        // Given
        let deck = SetGame.Deck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 0)
        let card = game.tableCards[0]
        
        // Then
        XCTAssertFalse(card.isSelected)
    }
}
