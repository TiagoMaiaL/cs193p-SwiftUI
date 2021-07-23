//
//  Memorize.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import Foundation

struct Memorize<Content> where Content: Hashable {
    
    // MARK: Properties
    
    private(set) var cards: [Card<Content>]
    
    private var unmatchedCards: [Card<Content>] {
        cards.filter { !$0.isMatched }
    }
    
    var isFinished: Bool { !cards.isEmpty && unmatchedCards.isEmpty }
    
    private(set) var score = 0
    
    private var viewedCards = Set<Card<Content>>()
    
    private var currentFacedUpPair: (firstIndex: Int, secondIndex: Int)? {
        let facedUpCards = unmatchedCards.filter { $0.isFaceUp }
        
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
        guard !cards[index].isMatched else {
            return
        }
        
        if let pair = currentFacedUpPair {
            guard index != pair.firstIndex, index != pair.secondIndex else {
                return
            }
            
            performMatch()
        }
        
        if cards[index].isFaceUp {
            score -= 1
            viewedCards.insert(cards[index])
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
        
        let isAMatch = firstCard.content == secondCard.content
        
        [pair.firstIndex, pair.secondIndex].forEach {
            cards[$0].isMatched = isAMatch
            cards[$0].isFaceUp = isAMatch
            
            if !isAMatch {
                let card = cards[$0]
                
                if viewedCards.contains(card) {
                    score -= 1
                }
                
                viewedCards.insert(card)
            }
        }
    }
}
