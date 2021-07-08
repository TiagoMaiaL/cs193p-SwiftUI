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
}
