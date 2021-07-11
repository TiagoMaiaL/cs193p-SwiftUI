//
//  EmojiCardViewModelTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 11/07/21.
//

import XCTest
@testable import Memorize

class EmojiCardViewModelTests: XCTestCase {

    // MARK: Tests
    
    func testThatTheViewModelInformsTheCardEmoji() {
        let card = Card<Emoji>(content: "🧐")
        let viewModel = EmojiCardViewModel(card: card)
        
        XCTAssertEqual(card.content, viewModel.content)
    }
    
    func testThatTheViewModelInformsIfTheCardIsFacedUp() {
        let card = Card<Emoji>(content: "🧐", isFaceUp: true)
        let viewModel = EmojiCardViewModel(card: card)
        
        XCTAssertEqual(card.isFaceUp, viewModel.isFaceUp)
    }
    
    func testThatTheViewModelInformsIfTheCardIsMatched() {
        let card = Card<Emoji>(content: "🧐", isMatched: true)
        let viewModel = EmojiCardViewModel(card: card)
        
        XCTAssertEqual(card.isMatched, viewModel.isMatched)
    }
}
