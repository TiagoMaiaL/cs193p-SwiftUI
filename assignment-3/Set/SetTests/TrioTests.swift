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
    
    // MARK: Contains
    
    func testTrioContainsCard() {
        // Given
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = SetGame.Card(color: .third, shape: .first, count: .one, shading: .first)
        
        let trio = SetGame.Trio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.contains(third) ?? false)
    }
    
    func testTrioDoesNotContainCard() {
        // Given
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = SetGame.Card(color: .third, shape: .first, count: .one, shading: .first)
        
        let trio = SetGame.Trio(first: first, second: second, third: third)
        
        let fourth = SetGame.Card(color: .first, shape: .second, count: .one, shading: .first)
        
        // Then
        XCTAssertFalse(trio?.contains(fourth) ?? true)
    }
    
    // MARK: Matching
    
    func testMatchingASetWithDifferentColors() {
        // Given
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = SetGame.Card(color: .third, shape: .first, count: .one, shading: .first)
        
        let trio = SetGame.Trio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    func testMatchingASetWithEqualColorsAndDifferentShapes() {
        // Given
        let first = SetGame.Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = SetGame.Card(color: .first, shape: .second, count: .one, shading: .first)
        let third = SetGame.Card(color: .first, shape: .third, count: .one, shading: .first)
        
        let trio = SetGame.Trio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    // TODO: Test the match method with the shape features.
    // TODO: Test the match method with the count features.
    // TODO: Test the match method with the shading features.
}
