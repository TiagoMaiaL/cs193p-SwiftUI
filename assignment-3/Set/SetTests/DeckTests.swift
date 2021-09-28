//
//  DeckTests.swift
//  SetTests
//
//  Created by Tiago Lopes on 25/09/21.
//

import XCTest
@testable import Set

class DeckTests: XCTestCase {
    
    // MARK: Constants
    
    let totalCardsCount = 81

    // MARK: Creation Tests

    func testCreation() {
        // Given
        let deck = SetGame.Deck()
        
        // Then
        XCTAssertEqual(deck.cards.count, totalCardsCount)
        XCTAssertEqual(deck.cards, DeckConstants.cards)
    }
    
    // MARK: Dealing Tests
    
    func testDefaultDealing() {
        // Given
        var deck = SetGame.Deck()
        
        // When
        let dealtCards = deck.deal()
        
        // Then
        XCTAssertEqual(deck.cards.count, totalCardsCount - 3)
        XCTAssertEqual(dealtCards.count, 3)
        XCTAssertTrue(Set(dealtCards).isDisjoint(with: deck.cards))
    }
    
    func testDealingAnyAmountOfCards() {
        // Given
        var deck = SetGame.Deck()
        let amountToDeal = 12
        
        // When
        let dealtCards = deck.deal(amount: amountToDeal)
        
        // Then
        XCTAssertEqual(deck.cards.count, totalCardsCount - amountToDeal)
        XCTAssertEqual(dealtCards.count, amountToDeal)
    }
    
    func testDealingReturnsNoCardsIfDeckIsEmpty() {
        // Given
        var deck = SetGame.Deck()
        
        // When
        _ = deck.deal(amount: totalCardsCount)
        let dealtCards = deck.deal()
        
        // Then
        XCTAssertEqual(dealtCards.count, 0)
        XCTAssertEqual(deck.cards.count, 0)
    }
    
    func testDealingReturnsAllLeftOverCards() {
        // Given
        var deck = SetGame.Deck()
        
        // When
        _ = deck.deal(amount: totalCardsCount - 2)
        let dealtCards = deck.deal(amount: 5)
        
        // Then
        XCTAssertEqual(dealtCards.count, 2)
        XCTAssertEqual(deck.cards.count, 0)
    }
    
    // MARK: isEmpty Tests
    
    func testDeckStartsNonEmpty() {
        // Given
        let deck = SetGame.Deck()
        
        // Then
        XCTAssertFalse(deck.isEmpty)
    }
    
    func testDeckGetsEmptyAfterDealingAllCards() {
        // Given
        var deck = SetGame.Deck()
        
        // When
        _ = deck.deal(amount: totalCardsCount)
        
        // Then
        XCTAssertTrue(deck.isEmpty)
    }
}