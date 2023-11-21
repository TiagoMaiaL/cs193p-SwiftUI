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
        let card = Memorize<Emoji>.Card(content: "🧐")
        let viewModel = EmojiCardViewModel(card: card)
        
        XCTAssertEqual(card.content, viewModel.content)
    }
    
    func testThatTheViewModelInformsIfTheCardIsFacedUp() {
        let card = Memorize<Emoji>.Card(content: "🧐", isFaceUp: true)
        let viewModel = EmojiCardViewModel(card: card)
        
        XCTAssertEqual(card.isFaceUp, viewModel.isFaceUp)
    }
    
    func testThatTheViewModelInformsIfTheCardIsMatched() {
        let card = Memorize<Emoji>.Card(content: "🧐", isMatched: true)
        let viewModel = EmojiCardViewModel(card: card)
        
        XCTAssertEqual(card.isMatched, viewModel.isMatched)
    }
}
