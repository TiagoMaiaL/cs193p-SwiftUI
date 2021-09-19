//
//  ThemeTests.swift
//  MemorizeTests
//
//  Created by Tiago Lopes on 08/07/21.
//

import XCTest
@testable import Memorize

class ThemeTests: XCTestCase {

    // MARK: Tests

    func testDefaultInitialization() {
        let name = "nature"
        let pairsCount = 5
        let options = [1, 2, 3, 4, 5]
        let color = Theme<Int>.Color.green
        
        let theme = Theme(
            name: name,
            pairsCount: pairsCount,
            options: options,
            color: color
        )
        
        XCTAssertEqual(theme.name, name)
        XCTAssertEqual(theme.pairsCount, pairsCount)
        XCTAssertEqual(theme.options, options)
        XCTAssertEqual(theme.color, color)
    }
    
    func testInitializingWithoutSpecifyingNumberOfPairs() {
        let name = "sports"
        let options = [1, 2, 3, 4, 5]
        let color = Theme<Int>.Color.green
        
        let theme = Theme(
            name: name,
            options: options,
            color: color
        )
        
        XCTAssertEqual(theme.pairsCount, options.count)
    }
    
    func testInitializingSpecifyingWrongNumberOfPairs() {
        let name = "sports"
        let pairsCount = 7 // Greater than the number of options.
        let options = [1, 2, 3, 4, 5]
        let color = Theme<Int>.Color.green
        
        let theme = Theme(
            name: name,
            pairsCount: pairsCount,
            options: options,
            color: color
        )
        
        XCTAssertEqual(theme.pairsCount, options.count)
    }
    
    func testThatShufflingReturnsRandomPairOptions() {
        let name = "sports"
        let options = [1, 2, 3, 4, 5]
        let color = Theme<Int>.Color.green
        
        let theme = Theme(
            name: name,
            options: options,
            color: color
        )
        
        XCTAssertNotEqual(theme.shuffledOptions, options)
    }
    
    func testThatShufflingReturnsRandomPairsUpToSpecifiedPairCount() {
        let name = "sports"
        let pairsCount = 3 // Smaller than the number of options.
        let options = [1, 2, 3, 4, 5]
        let color = Theme<Int>.Color.green
        
        let theme = Theme(
            name: name,
            pairsCount: pairsCount,
            options: options,
            color: color
        )
        
        XCTAssertEqual(theme.shuffledOptions.count, 3)
    }
    
    func testThatRandomOptionsAreWithinAllowedRange() {
        let options = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
        let maxRandomPairs = 8
        
        let theme = Theme(
            name: name,
            options: options,
            color: .gray,
            maxRandomPairs: maxRandomPairs
        )
        
        XCTAssertTrue((2...maxRandomPairs).contains(theme.pairsCount))
    }
}
