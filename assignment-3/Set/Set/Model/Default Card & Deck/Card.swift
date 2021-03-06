//
//  Card.swift
//  Set
//
//  Created by Tiago Lopes on 23/09/21.
//

import Foundation

// MARK: - Card

struct Card {
    
    // MARK: Properties
    
    private let _id = UUID()
    
    var _isSelected = false
    var _isMatched = false
    var _isUnmatched = false
    
    let color: ColorFeature
    let shape: ShapeFeature
    let count: CountFeature
    let shading: ShadingFeature
    
    // MARK: Initializer
    
    init(
        color: ColorFeature,
        shape: ShapeFeature,
        count: CountFeature,
        shading: ShadingFeature
    ) {
        self.color = color
        self.shape = shape
        self.count = count
        self.shading = shading
    }
}

// MARK: - Card Feature

extension Card {
    enum ColorFeature: CaseIterable {
        case first
        case second
        case third
    }
    
    enum ShapeFeature: CaseIterable {
        case first
        case second
        case third
    }
    
    enum CountFeature: CaseIterable {
        case one
        case two
        case three
    }
    
    enum ShadingFeature: CaseIterable {
        case first
        case second
        case third
    }
}

// MARK: - Hashable

extension Card: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(color)
        hasher.combine(shape)
        hasher.combine(count)
        hasher.combine(shading)
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return (
            lhs.color == rhs.color &&
            lhs.shape == rhs.shape &&
            lhs.count == rhs.count &&
            lhs.shading == rhs.shading
        )
    }
}

// MARK: - SetCard Conformance

extension Card: SetCard {
    
    var id: UUID {
        _id
    }
    
    var isSelected: Bool {
        get { _isSelected }
        set { _isSelected = newValue }
    }
    
    var isMatched: Bool {
        get { _isMatched }
        set { _isMatched = newValue }
    }
    
    var isUnmatched: Bool {
        get { _isUnmatched }
        set { _isUnmatched = newValue }
    }
    
    var firstFeature: ColorFeature { color }
    var secondFeature: ShapeFeature { shape }
    var thirdFeature: CountFeature { count }
    var fourthFeature: ShadingFeature { shading }
    
    init(firstFeature: ColorFeature,
         secondFeature: ShapeFeature,
         thirdFeature: CountFeature,
         fourthFeature: ShadingFeature) {
        self.init(color: firstFeature, shape: secondFeature, count: thirdFeature, shading: fourthFeature)
    }
}
