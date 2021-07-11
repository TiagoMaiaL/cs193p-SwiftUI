//
//  MemorizeViewModelTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 10/07/21.
//

import XCTest
@testable import Memorize

class MemorizeViewModelTests: XCTestCase {
    
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
}
