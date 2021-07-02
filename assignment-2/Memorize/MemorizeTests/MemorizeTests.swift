//
//  MemorizeTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 30/06/21.
//

import XCTest
@testable import Memorize

class MemorizeTests: XCTestCase {
    
    // MARK: Properties
    
    private let pairsCount = 5
    private var memorize: Memorize<String>!
    
    // MARK: Setup/Teardown
    
    override func setUp() {
        super.setUp()
        
        memorize = Memorize(
            pairsCount: 5,
            contentProvider: { index in String(describing: index) }
        )
    }

    override func tearDown() {
        memorize = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testThatTheGameHas10Cards() {
        XCTAssertEqual(memorize.cards.count, pairsCount * 2)
    }
    
    func testThatTheGameStartsAsUnfinished() {
        XCTAssertFalse(memorize.isFinished)
    }
    
    func testThatACardHasTheRightContentType() {
        let card = memorize.cards[0]
        XCTAssertNotNil(Int(card.content))
    }
    
    func testThatGameStartsWithNoMatchedCards() {
        let matchedCards = memorize.cards.filter { $0.isMatched }
        XCTAssertTrue(matchedCards.isEmpty)
    }
    
    func testThatGameStartWithAllCardsFacedDown() {
        let facedUpCards = memorize.cards.filter { $0.isFaceUp }
        XCTAssertTrue(facedUpCards.isEmpty)
    }
    
    func testThatTheGameHasCardsInShuffledOrder() {
        let orderedCards = (0 ..< pairsCount * 2).map(String.init(describing:))
        XCTAssertNotEqual(orderedCards, memorize.cards.map(\.content))
    }
    
    func testChoosingACard() {
        let index = 0
        memorize.chooseCard(atIndex: index)
        XCTAssertTrue(memorize.cards[index].isFaceUp)
    }
    
    func testFlippingACardDown() {
        let index = 0
        memorize.chooseCard(atIndex: index)
        memorize.chooseCard(atIndex: index)
        XCTAssertFalse(memorize.cards[index].isFaceUp)
    }
}
