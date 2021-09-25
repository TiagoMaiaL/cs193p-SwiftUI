//
//  DeckTests.swift
//  SetTests
//
//  Created by Tiago Lopes on 25/09/21.
//

import XCTest
@testable import Set

class DeckTests: XCTestCase {

    // MARK: Tests

    func testDeckCreation() {
        // Given
        let deck = SetGame.Deck()
        
        // Then
        XCTAssertEqual(deck.cards.count, 81)
        XCTAssertEqual(deck.cards, DeckConstants.cards)
    }
}
