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
        let deck = FullDeck()
        
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
        let deck = FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.deal()
        
        // Then
        XCTAssertEqual(game.tableCards.count, initialCardsAmount + dealtCardsCount)
    }
    
    // MARK: - Choosing Cards
    
    func testItSelectsACardWhenTheUserChoosesOne() {
        // Given
        let deck = FullDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        let card = game.tableCards[0]
        
        // Then
        XCTAssertTrue(card.isSelected)
    }
    
    func testItAllowsDeselection() {
        // Given
        let deck = FullDeck()
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
        let deck = FullDeck()
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
        let deck = FullDeck()
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
        let deck = FullDeck()
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
        let deck = FullDeck()
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
    
    // MARK: Matching Cards
    
    func testTheChosenCardsAreMatched() {
        // Given
        let deck = MatchingDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertTrue(game.tableCards[0].isMatched)
        XCTAssertTrue(game.tableCards[1].isMatched)
        XCTAssertTrue(game.tableCards[2].isMatched)
    }
    
    func testTheChosenCardsDoNotMatch() {
        // Given
        let deck = NonMatchingDeck()
        var game = SetGame(deck: deck)
        
        // When
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertFalse(game.tableCards[0].isMatched)
        XCTAssertFalse(game.tableCards[1].isMatched)
        XCTAssertFalse(game.tableCards[2].isMatched)
    }
    
    // MARK: Removing Matched Cards
    
    func testTheMatchedCardsAreRemovedAfterANewSelection() {
        // Given
        let deck = MatchingDeck()
        var game = SetGame(deck: deck)
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        // When
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertTrue(game.tableCards.isEmpty)
    }
    
    func testTheMatchedCardsAreMovedToTheMatchedPileAfterANewSelection() {
        // Given
        let deck = MatchingDeck()
        var game = SetGame(deck: deck)
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        let matchedCards = game.tableCards
        
        // When
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertEqual(game.matchedCards, Set(matchedCards))
    }
    
    // MARK: Dealing After Matching
    
    func testThatCardsAreDealtAfterAMatch() {
        // Given
        let deck = MatchingDeck()
        var game = SetGame(deck: deck)
        
        let cardToBeDealt = Card(
            color: .third,
            shape: .first,
            count: .two,
            shading: .second
        )
        deck.insert(cardToBeDealt)
        
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        // When
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertEqual(Set(game.tableCards), Set([cardToBeDealt]))
    }
    
    func testThatCardsAreNotDealtAfterAFailedMatchAttempt() {
        // Given
        let deck = NonMatchingDeck()
        var game = SetGame(deck: deck)
        
        let extraCard = Card(
            color: .third,
            shape: .first,
            count: .two,
            shading: .second
        )
        deck.insert(extraCard)
        
        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        // When
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertEqual(game.tableCards.count, 3)
        XCTAssertEqual(deck._cards.first, extraCard)
    }
    
    func testThatAFourthCardIsSelectedAfterAMatch() {
        // Given
        let deck = MatchingDeck()
        let matchingCards = Array(deck._cards)
        let fourthCard = Card(
            color: .third,
            shape: .first,
            count: .two,
            shading: .second
        )
        deck.insert(fourthCard)

        var game = SetGame(deck: deck)
        
        matchingCards
            .compactMap { game.tableCards.firstIndex(of: $0) }
            .forEach { game.chooseCard(atIndex: $0) }
        
        // When
        guard let fourthCardIndex = game.tableCards.firstIndex(of: fourthCard) else {
            XCTFail()
            return
        }
        game.chooseCard(atIndex: fourthCardIndex)
        
        
        // Then
        XCTAssertTrue(game.tableCards.first?.isSelected ?? false)
    }
    
    func testThatAFourthCardIsSelectedAfterAFailedMatchAttempt() {
        // Given
        let deck = NonMatchingDeck()
        let nonMatchingCards = Array(deck._cards)
        let fourthCard = Card(
            color: .third,
            shape: .first,
            count: .two,
            shading: .second
        )
        deck.insert(fourthCard)

        var game = SetGame(deck: deck)
        
        nonMatchingCards
            .compactMap { game.tableCards.firstIndex(of: $0) }
            .forEach { game.chooseCard(atIndex: $0) }
        
        // When
        guard let fourthCardIndex = game.tableCards.firstIndex(of: fourthCard) else {
            XCTFail()
            return
        }
        game.chooseCard(atIndex: fourthCardIndex)
        
        // Then
        XCTAssertTrue(game.tableCards[fourthCardIndex].isSelected)
    }
    
    // MARK: Unselecting After Matching
    
    func testThatCardsAreUnselectedAfterAMismatch() {
        // Given
        let deck = NonMatchingDeck()
        var game = SetGame(deck: deck)

        game.chooseCard(atIndex: 0)
        game.chooseCard(atIndex: 1)
        game.chooseCard(atIndex: 2)
        
        // When
        game.chooseCard(atIndex: 2)
        
        // Then
        XCTAssertFalse(game.tableCards[0].isSelected)
        XCTAssertFalse(game.tableCards[1].isSelected)
        XCTAssertTrue(game.tableCards[2].isSelected)
    }
    
    func testThatTheUnmatchedTrioIsUnselectedAfterChoosingAFourthCard() {
        // Given
        let deck = NonMatchingDeck()
        let nonMatchingCards = Array(deck._cards)
        let fourthCard = Card(
            color: .third,
            shape: .first,
            count: .two,
            shading: .second
        )
        deck.insert(fourthCard)

        var game = SetGame(deck: deck)
        
        nonMatchingCards
            .compactMap(game.tableCards.firstIndex(of:))
            .forEach { game.chooseCard(atIndex: $0) }
        
        // When
        guard let fourthCardIndex = game.tableCards.firstIndex(of: fourthCard) else {
            XCTFail()
            return
        }
        game.chooseCard(atIndex: fourthCardIndex)
        
        // Then
        nonMatchingCards
            .compactMap(game.tableCards.firstIndex(of:))
            .forEach {
                XCTAssertFalse(game.tableCards[$0].isSelected)
            }
        
        XCTAssertTrue(game.tableCards[fourthCardIndex].isSelected)
    }
}
