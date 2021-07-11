//
//  Memorize.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import Foundation

struct Memorize<Content> where Content: Equatable {
    
    // MARK: Properties
    
    private(set) var cards: [Card<Content>]
    
    private var unmatchedCards: [Card<Content>] {
        cards.filter { !$0.isMatched }
    }
    
    var isFinished: Bool { !cards.isEmpty && unmatchedCards.isEmpty }
    
    private var currentFacedUpPair: (firstIndex: Int, secondIndex: Int)? {
        let facedUpCards = cards.filter { $0.isFaceUp }
        
        guard facedUpCards.count == 2,
              let firstCardIndex = cards.firstIndex(of: facedUpCards[0]),
              let secondCardIndex = cards.firstIndex(of: facedUpCards[1]) else {
                  return nil
              }
        
        return (firstCardIndex, secondCardIndex)
    }
    
    private var isLastPairBeingMatched: Bool {
        unmatchedCards.count == 2
    }
    
    // MARK: Initializer
    
    init(pairsCount: Int, contentProvider: (Int) -> Content) {
        var cards = [Card<Content>]()
        
        for index in 0 ..< pairsCount {
            let pair = [
                Card<Content>(content: contentProvider(index)),
                Card<Content>(content: contentProvider(index))
            ]
            cards.append(contentsOf: pair)
        }
        
        self.cards = cards.shuffled()
    }
    
    // MARK: Imperatives
    
    mutating func chooseCard(atIndex index: Int) {
        if let pair = currentFacedUpPair {
            guard index != pair.firstIndex, index != pair.secondIndex else {
                return
            }
            
            performMatch()
        }
        
        cards[index].isFaceUp.toggle()
        
        if isLastPairBeingMatched {
            performMatch()
        }
    }
    
    // MARK: Internal Methods
    
    mutating private func performMatch() {
        guard let pair = currentFacedUpPair else {
            return
        }
        
        let firstCard = cards[pair.firstIndex]
        let secondCard = cards[pair.secondIndex]
        
        [pair.firstIndex, pair.secondIndex].forEach {
            cards[$0].isMatched = firstCard.content == secondCard.content
            cards[$0].isFaceUp = false
        }
    }
}