//
//  TrioTests.swift
//  SetTests
//
//  Created by Tiago Lopes on 30/09/21.
//

import XCTest
@testable import Set

class TrioTests: XCTestCase {
    
    // MARK: Initialization
    
    func testTrioInitializesCorrectly() {
        // Given
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = SetGame.Card(color: .third, shape: .first, count: .one, shading: .first)
        
        // When
        let trio = SetGame.Trio(first: first, second: second, third: third)
        
        // Then
        XCTAssertNotNil(trio)
    }
    
    func testTrioDoesNotInitializeBecauseSomeCardsAreEqual() {
        // Given
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let third = SetGame.Card(color: .third, shape: .first, count: .one, shading: .first)
        
        // When
        let trio = SetGame.Trio(first: first, second: second, third: third)
        
        // Then
        XCTAssertNil(trio)
    }
}
