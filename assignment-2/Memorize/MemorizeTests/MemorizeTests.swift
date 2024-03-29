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
        
        memorize = Memorize(pairsCount: pairsCount, contentProvider: String.init)
    }

    override func tearDown() {
        memorize = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testThatTheGameHas10Cards() {
        XCTAssertEqual(memorize.cards.count, pairsCount * 2)
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
        XCTAssertNotEqual(orderedCards, memorize.cards.map(\.content))
    }
    
    func testChoosingACard() {
        let index = 0
        memorize.chooseCard(atIndex: index)
        XCTAssertTrue(memorize.cards[index].isFaceUp)
    }
    
    func testThatChoosingACardInAFacedUpPairShouldBeForbidden() {
        let firstCardIndex = 0
        let secondCardIndex = 1
        
        memorize.chooseCard(atIndex: firstCardIndex)
        memorize.chooseCard(atIndex: secondCardIndex)
        
        // Try turning the first card face down.
        memorize.chooseCard(atIndex: firstCardIndex)
        XCTAssertTrue(memorize.cards[firstCardIndex].isFaceUp)
        
        // Try turning the second card face down.
        memorize.chooseCard(atIndex: secondCardIndex)
        XCTAssertTrue(memorize.cards[secondCardIndex].isFaceUp)
    }
    
    func testTryingAWrongMatch() throws {
        let nonMatchingPair = try findNonMatchingPair()
        let thirdCardIndex = try findThirdCard(from: nonMatchingPair)
        
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        memorize.chooseCard(atIndex: nonMatchingPair.second)
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        XCTAssertTrue(memorize.cards.filter { $0.isMatched }.isEmpty)
        XCTAssertFalse(memorize.cards[nonMatchingPair.first].isFaceUp)
        XCTAssertFalse(memorize.cards[nonMatchingPair.second].isFaceUp)
        XCTAssertTrue(memorize.cards[thirdCardIndex].isFaceUp)
    }
    
    func testTryingACorrectMatch() throws {
        let matchingPair = try findMatchingPair()
        let thirdCardIndex = try findThirdCard(from: matchingPair)
        
        memorize.chooseCard(atIndex: matchingPair.first)
        memorize.chooseCard(atIndex: matchingPair.second)
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        XCTAssertTrue(memorize.cards[matchingPair.first].isMatched)
        XCTAssertTrue(memorize.cards[matchingPair.second].isMatched)
        XCTAssertFalse(memorize.cards[matchingPair.first].isFaceUp)
        XCTAssertFalse(memorize.cards[matchingPair.second].isFaceUp)
        XCTAssertTrue(memorize.cards[thirdCardIndex].isFaceUp)
    }
    
    func testThatChoosingAMatchedCardIsImpossible() throws {
        let matchingPair = try findMatchingPair()
        let thirdCardIndex = try findThirdCard(from: matchingPair)
        
        // Perform the correct match.
        memorize.chooseCard(atIndex: matchingPair.first)
        memorize.chooseCard(atIndex: matchingPair.second)
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        // Choose a matched card.
        memorize.chooseCard(atIndex: matchingPair.first)

        // It shouldn't get flipped anymore.
        XCTAssertFalse(memorize.cards[matchingPair.first].isFaceUp)
    }
    
    func testTryingTheLastMatch() {
        memorize = Memorize(pairsCount: 1, contentProvider: String.init)
        
        memorize.chooseCard(atIndex: 0)
        memorize.chooseCard(atIndex: 1)
        
        XCTAssertTrue(memorize.cards[0].isMatched)
        XCTAssertTrue(memorize.cards[1].isMatched)
    }
    
    func testFinishingTheGame() {
        memorize = Memorize(pairsCount: 1, contentProvider: String.init)
        
        memorize.chooseCard(atIndex: 0)
        memorize.chooseCard(atIndex: 1)
    }
    
    func testThatTheScoreStartsAtZero() {
        XCTAssertEqual(memorize.score, 0)
    }
    
    func testThatPerformingAMismatchWithNoViewedCardsIsNotPenalized() throws {
        let nonMatchingPair = try findNonMatchingPair()
        let thirdCardIndex = try findThirdCard(from: nonMatchingPair)
        
        // Perform the mismatch.
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        memorize.chooseCard(atIndex: nonMatchingPair.second)
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        XCTAssertEqual(memorize.score, 0)
    }
    
    func testThatTheUserIsPenalizedForAMismatchWhenOneOfTheCardsWasAlreadyViewed() throws {
        let nonMatchingPair = try findNonMatchingPair()
        let thirdCardIndex = try findThirdCard(from: nonMatchingPair)
        
        // Choose the non matching pair.
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        memorize.chooseCard(atIndex: nonMatchingPair.second)
        
        // Perform the mismatch by choosing a third card and flipping the others down, marking them as viewed.
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        // Choose a second pair (thirdCardIndex and nonMatchingPair.first), using one of the previously seen cards.
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        
        // Perform the second mismatch by choosing a third card.
        memorize.chooseCard(atIndex: nonMatchingPair.second)

        XCTAssertEqual(memorize.score, -1)
    }
    
    func testThatTheUserIsPenalizedForAMismatchWhenTheWholePairWasAlreadyViewed() throws {
        let nonMatchingPair = try findNonMatchingPair()
        let thirdCardIndex = try findThirdCard(from: nonMatchingPair)
        
        // Choose a non matching pair.
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        memorize.chooseCard(atIndex: nonMatchingPair.second)
        
        // Perform the mismatch by choosing a third card and flipping the others down, marking them as viewed (score is 0).
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        // Choose a new pair, using the first card from nonMatchingPair.
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        
        // Perform a second mismatch, while choosing a third pair, using the second card from nonMatchingPair (score is now -1).
        memorize.chooseCard(atIndex: nonMatchingPair.second)
        
        // Choose the second card of a non-matching pair (all cards are now marked as viewed, meaning a mismatch will be scored -2).
        memorize.chooseCard(atIndex: nonMatchingPair.first)
        
        // Perform the mismatch on the face up card. The score is now -3: the previous -1 with the mismatch involving 2 viewed cards (-2).
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        XCTAssertEqual(memorize.score, -3)
    }
    
    func testThatTheUserScoresTwoPointsForAMatch() throws {
        let matchingPair = try findMatchingPair()
        let thirdCardIndex = try findThirdCard(from: matchingPair)
        
        // Perform the correct match.
        memorize.chooseCard(atIndex: matchingPair.first)
        memorize.chooseCard(atIndex: matchingPair.second)
        memorize.chooseCard(atIndex: thirdCardIndex)
        
        XCTAssertEqual(memorize.score, 2)
    }
}

// MARK: - Errors

private extension MemorizeTests {
    enum Failures: Error, CustomStringConvertible {
        case indexNotFound(description: String)
        
        var description: String {
            switch self {
            case .indexNotFound(let description):
                return description
            }
        }
    }
}

// MARK: - Helper Functions

private extension MemorizeTests {
    typealias IndexedPair = (first: Int, second: Int)
    
    func findMatchingPair() throws -> IndexedPair {
        let firstCardIndex = 0
        let firstCard = memorize.cards[firstCardIndex]
        
        guard let secondCardIndex = memorize.cards.firstIndex(
            where: { $0.content == firstCard.content && $0.id != firstCard.id }
        ) else {
            throw Failures.indexNotFound(
                description: "Couldn't find a matching pair."
            )
        }
        
        return (firstCardIndex, secondCardIndex)
    }
    
    func findNonMatchingPair() throws -> IndexedPair {
        let firstCardIndex = 0
        let firstCard = memorize.cards[firstCardIndex]
        
        guard let secondCardIndex = memorize.cards.firstIndex(
            where: { $0.content != firstCard.content }
        ) else {
            throw Failures.indexNotFound(
                description: "Couldn't find a wrong pair of cards to be matched."
            )
        }
        
        return (firstCardIndex, secondCardIndex)
    }
    
    func findThirdCard(from pair: IndexedPair) throws -> Int {
        let firstCard = memorize.cards[pair.first]
        let secondCard = memorize.cards[pair.second]
        
        guard let thirdIndex = memorize.cards.firstIndex(
            where: {
                $0.id != firstCard.id &&
                $0.id != secondCard.id &&
                $0.content != firstCard.content &&
                $0.content != secondCard.content
            }
        ) else {
            throw Failures.indexNotFound(
                description: "Couldn't find a third different card."
            )
        }
        
        return thirdIndex
    }
}
