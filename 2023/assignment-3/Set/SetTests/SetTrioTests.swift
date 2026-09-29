//
//  SetTrioTests.swift
//  SetTests
//
//  Created by Tiago Lopes on 30/09/21.
//

import XCTest
@testable import Set

class SetTrioTests: XCTestCase {
    
    // MARK: Initialization
    
    func testTrioInitializesCorrectly() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = Card(color: .third, shape: .first, count: .one, shading: .first)
        
        // When
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertNotNil(trio)
    }
    
    func testTrioDoesNotInitializeBecauseSomeCardsAreEqual() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .first, shape: .first, count: .one, shading: .first)
        let third = Card(color: .third, shape: .first, count: .one, shading: .first)
        
        // When
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertNil(trio)
    }
    
    // MARK: Contains
    
    func testTrioContainsCard() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = Card(color: .third, shape: .first, count: .one, shading: .first)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.contains(third) ?? false)
    }
    
    func testTrioDoesNotContainCard() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = Card(color: .third, shape: .first, count: .one, shading: .first)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        let fourth = Card(color: .first, shape: .second, count: .one, shading: .first)
        
        // Then
        XCTAssertFalse(trio?.contains(fourth) ?? true)
    }
    
    // MARK: Matching
    
    func testMatchingASetWithDifferentColors() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .one, shading: .first)
        let third = Card(color: .third, shape: .first, count: .one, shading: .first)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    func testMatchingASetWithEqualColorsAndDifferentShapes() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .first, shape: .second, count: .one, shading: .first)
        let third = Card(color: .first, shape: .third, count: .one, shading: .first)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    func testMatchingASetWithDifferentCounts() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .two, shading: .first)
        let third = Card(color: .third, shape: .first, count: .three, shading: .first)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    func testMatchingASetWithDifferentShadings() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .two, shading: .second)
        let third = Card(color: .third, shape: .first, count: .three, shading: .third)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    func testMatchingASetWithTotallyDifferentFeatures() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .second, count: .two, shading: .second)
        let third = Card(color: .third, shape: .third, count: .three, shading: .third)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertTrue(trio?.isSet ?? false)
    }
    
    func testMatchingASetWithWrongColors() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .first, shape: .first, count: .two, shading: .second)
        let third = Card(color: .third, shape: .first, count: .three, shading: .third)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertFalse(trio?.isSet ?? true)
    }
    
    func testMatchingASetWithWrongShapes() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .first, count: .two, shading: .second)
        let third = Card(color: .third, shape: .third, count: .three, shading: .third)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertFalse(trio?.isSet ?? true)
    }
    
    func testMatchingASetWithWrongCounts() {
        // Given
        let first = Card(color: .first, shape: .first, count: .two, shading: .first)
        let second = Card(color: .second, shape: .second, count: .two, shading: .second)
        let third = Card(color: .third, shape: .third, count: .three, shading: .third)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertFalse(trio?.isSet ?? true)
    }
    
    func testMatchingASetWithWrongShadings() {
        // Given
        let first = Card(color: .first, shape: .first, count: .one, shading: .first)
        let second = Card(color: .second, shape: .second, count: .two, shading: .first)
        let third = Card(color: .third, shape: .third, count: .three, shading: .second)
        
        let trio = SetTrio(first: first, second: second, third: third)
        
        // Then
        XCTAssertFalse(trio?.isSet ?? true)
    }
}
