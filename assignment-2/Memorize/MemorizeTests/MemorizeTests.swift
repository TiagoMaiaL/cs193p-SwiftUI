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
        let orderedCards = (0 ..< pairsCount)
            .map(String.init(describing:))
            .map { [$0, $0] }
            .reduce([], +)
        debugPrint(orderedCards)
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
    
    func testTryingAWrongMatch() {
        let initialChoiceIndex = 0
        let initialCard = memorize.cards[initialChoiceIndex]
        
        guard let nextWrongChoiceIndex = memorize.cards.firstIndex(
            where: { $0.content != initialCard.content }
        ) else {
            XCTFail("Couldn't find the index of a wrong card.")
            return
        }
        
        memorize.chooseCard(atIndex: initialChoiceIndex)
        memorize.chooseCard(atIndex: nextWrongChoiceIndex)
        
        // The match is performed when the third card is chosen:
        
        guard let thirdCardIndex = (0 ..< memorize.cards.count).first(
            where: { $0 != initialChoiceIndex && $0 != nextWrongChoiceIndex }
        ) else {
            XCTFail("Couldn't find the index of a third different card.")
            return
        }
        
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        XCTAssertTrue(memorize.cards.filter { $0.isMatched }.isEmpty)
        XCTAssertFalse(memorize.cards[initialChoiceIndex].isFaceUp)
        XCTAssertFalse(memorize.cards[nextWrongChoiceIndex].isFaceUp)
        XCTAssertTrue(memorize.cards[thirdCardIndex].isFaceUp)
    }
}
