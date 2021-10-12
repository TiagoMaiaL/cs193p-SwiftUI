//
//  SetCard.swift
//  Set
//
//  Created by Tiago Lopes on 12/10/21.
//

import Foundation

// MARK: - SetCard

protocol SetCard: Hashable {
    associatedtype FirstFeature: Hashable
    associatedtype SecondFeature: Hashable
    associatedtype ThirdFeature: Hashable
    associatedtype FourthFeature: Hashable
    
    var isSelected: Bool { get set }
    var isMatched: Bool { get set }
    
    var firstFeature: FirstFeature { get }
    var secondFeature: SecondFeature { get }
    var thirdFeature: ThirdFeature { get }
    var fourthFeature: FourthFeature { get }
}
