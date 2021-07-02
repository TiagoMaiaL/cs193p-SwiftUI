//
//  CardTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 01/07/21.
//

import XCTest
@testable import Memorize

class CardTests: XCTestCase {

    // MARK: Tests

    func testInitialization() {
        let card = Card<String>(
            content: "test"
        )
        XCTAssertEqual(card.content, "test")
        XCTAssertFalse(card.isFaceUp)
        XCTAssertFalse(card.isMatched)
    }
}