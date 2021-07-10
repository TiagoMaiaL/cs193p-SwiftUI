//
//  Memorize+ThemeTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 09/07/21.
//

import XCTest
@testable import Memorize

class Memorize_ThemeTests: XCTestCase {
    
    // MARK: Tests
    
    func testThatGameHasTheRightAmountOfCardsBasedOnTheTheme() {
        let theme = Theme(name: "test", options: [1, 2, 3, 4], color: .green)
        let memorize = Memorize(theme: theme)
        
        XCTAssertEqual(memorize.cards.count, theme.options.count * 2)
    }
    
    func testThatGameHasCorrectCardsBasedOnTheTheme() {
        let theme = Theme(name: "test", options: [1, 2, 3], color: .green)
        let memorize = Memorize(theme: theme)
        
        XCTAssertEqual(
            Set(memorize.cards.map(\.content)),
            Set(theme.options)
        )
    }
    
    func testThatTheGameUsesTheThemeShuffledOptions() {
        let theme = Theme(name: "test", options: [1, 2, 3], color: .green)
        let memorize = Memorize(theme: theme)
        
        let orderedCardsContent = theme
            .options
            .map { [$0, $0] }
            .reduce([], +)
        
        XCTAssertNotEqual(memorize.cards.map(\.content), orderedCardsContent)
    }
    
    func testThatTheGameUsesTheThemeAmountOfPairs() {
        let theme = Theme(name: "test", pairsCount: 3, options: [1, 2, 3, 4, 5, 6], color: .green)
        let memorize = Memorize(theme: theme)
        
        XCTAssertEqual(memorize.cards.count, theme.pairsCount * 2)
    }
}
