//
//  SetCard.swift
//  Set
//
//  Created by Tiago Lopes on 12/10/21.
//

import Foundation

// MARK: - SetCard

protocol SetCard: Hashable {
    
    // MARK: Associated Types
    
    associatedtype ID: Hashable
    associatedtype FirstFeature: Hashable, CaseIterable
    associatedtype SecondFeature: Hashable, CaseIterable
    associatedtype ThirdFeature: Hashable, CaseIterable
    associatedtype FourthFeature: Hashable, CaseIterable
    
    // MARK: Initializer
    
    init(firstFeature: FirstFeature,
         secondFeature: SecondFeature,
         thirdFeature: ThirdFeature,
         fourthFeature: FourthFeature)
    
    // MARK: Properties
    
    var id: ID { get }
    
    var isSelected: Bool { get set }
    var isMatched: Bool { get set }
    
    var firstFeature: FirstFeature { get }
    var secondFeature: SecondFeature { get }
    var thirdFeature: ThirdFeature { get }
    var fourthFeature: FourthFeature { get }
}
