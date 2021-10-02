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
        let deck = SetGame.FullDeck()
        
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
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.deal()
        
        // Then
        XCTAssertEqual(game.tableCards.count, initialCardsAmount + dealtCardsCount)
    }
    
    // MARK: - Choosing Cards
    
    func testItSelectsACardWhenTheUserChoosesOne() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        let card = game.tableCards[0]
        
        // Then
        XCTAssertTrue(card.isSelected)
    }
    
    func testItAllowsDeselection() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 0)
        let card = game.tableCards[0]
        
        // Then
        XCTAssertFalse(card.isSelected)
    }
    
    func testItAllowsTwoCardsToBeChosen() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        let firstCard = game.tableCards[0]
        let secondCard = game.tableCards[1]
        
        // Then
        XCTAssertTrue(firstCard.isSelected)
        XCTAssertTrue(secondCard.isSelected)
    }
    
    func testItAllowsDeselectingTwoCards() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 1)
        let firstCard = game.tableCards[0]
        let secondCard = game.tableCards[1]
        
        // Then
        XCTAssertFalse(firstCard.isSelected)
        XCTAssertFalse(secondCard.isSelected)
    }
    
    func testItAllowsDeselectingOneOfTheCardsAfterTwoAreChosen() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 1)
        let firstCard = game.tableCards[0]
        let secondCard = game.tableCards[1]
        
        // Then
        XCTAssertTrue(firstCard.isSelected)
        XCTAssertFalse(secondCard.isSelected)
    }
    
    func testItAllowsSelectingThreeCardsAtTheSameTime() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        let firstCard = game.tableCards[0]
        let secondCard = game.tableCards[1]
        let thirdCard = game.tableCards[2]
        
        // Then
        XCTAssertTrue(firstCard.isSelected)
        XCTAssertTrue(secondCard.isSelected)
        XCTAssertTrue(thirdCard.isSelected)
    }

    func testItForbidsDeselectionOnceThreeCardsAreChosen() {
        // Given
        let deck = SetGame.FullDeck()
        var game = SetGame(deck: deck)

        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        let firstCard = game.tableCards[0]
        let secondCard = game.tableCards[1]
        let thirdCard = game.tableCards[2]

        // Then
        XCTAssertTrue(firstCard.isSelected)
        XCTAssertTrue(secondCard.isSelected)
        XCTAssertTrue(thirdCard.isSelected)
    }
    
    // MARK: Matching Cards
}
