//
//  EmojiMemorizeViewModelTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 10/07/21.
//

import XCTest
@testable import Memorize

class EmojiMemorizeViewModelTests: XCTestCase {
    
    // MARK: Properties
    
    var viewModel: EmojiMemorizeViewModel!
    
    // MARK: Setup / Teardown
    
    override func setUp() {
        super.setUp()
        viewModel = EmojiMemorizeViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }
    
    // MARK: Tests
    
    func testThatTheViewModelInitializesWithARandomEmojiTheme() {
        let themeName = viewModel.themeName
        let theme = EmojiThemes.allThemes.first(where: { $0.name == themeName })
        
        XCTAssertNotNil(theme)
    }
    
    func testThatTheViewModelInformsAThemeColor() {
        let themeName = viewModel.themeName
        let theme = EmojiThemes.allThemes.first(where: { $0.name == themeName })
        
        XCTAssertEqual(theme?.color, viewModel.themeColor)
    }
    
    func testThatTheViewModelInstantiatesEmojiCardViewModelInstances() {
        let themeName = viewModel.themeName
        let theme = EmojiThemes.allThemes.first(where: { $0.name == themeName })
        
        let firstCardContent = viewModel.cards[0].content
        
        XCTAssertTrue(theme?.options.contains(firstCardContent) ?? false)
    }
    
    func testThatTheViewModelHasTheRightAmountOfCards() {
        let themeName = viewModel.themeName
        let theme = EmojiThemes.allThemes.first(where: { $0.name == themeName })
        
        XCTAssertEqual(viewModel.cards.count, (theme?.pairsCount ?? 0) * 2)
    }
    
    func testThatTheGameHasNoRepeatedPairs() {
        let countedEmojis: [Emoji: Int] = viewModel
            .cards
            .map(\.content)
            .reduce([:], { countedEmojis, currentEmoji in
                var countedEmojis = countedEmojis
                
                let count = (countedEmojis[currentEmoji] ?? 0) + 1
                countedEmojis[currentEmoji] = count
                
                return countedEmojis
            })
        
        XCTAssertTrue(countedEmojis.filter { $1 > 2 }.isEmpty)
    }
    
    func testThatChoosingACardMakesItFacedUp() {
        viewModel.choose(viewModel.cards[0])
        
        XCTAssertTrue(viewModel.cards[0].isFaceUp)
    }
    
    func testThatChoosingACardMakesItFacedDown() {
        viewModel.choose(viewModel.cards[0])
        viewModel.choose(viewModel.cards[0])
        
        XCTAssertFalse(viewModel.cards[0].isFaceUp)
    }
    
    func testThatStartingANewGameStartsABrandNewGame() {
        let oldThemeName = viewModel.themeName
        
        viewModel.startNewGame()
        
        XCTAssertNotEqual(oldThemeName, viewModel.themeName)
        XCTAssertTrue(viewModel.cards.filter { $0.isFaceUp }.isEmpty)
        XCTAssertTrue(viewModel.cards.filter { $0.isMatched }.isEmpty)
    }
}
