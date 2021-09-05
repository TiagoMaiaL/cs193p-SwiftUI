//
//  Memorize.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import Foundation

struct Memorize<Content> where Content: Hashable {
    
    // MARK: Properties
    
    private(set) var cards: [Card]
    private(set) var score = 0
    private var viewedCards = Set<Card>()
    
    // TODO: Remove the isFinished.
    var isFinished: Bool { !cards.isEmpty && unmatchedCards.isEmpty }
    
    // MARK: Initializer
    
    init(pairsCount: Int, contentProvider: (Int) -> Content) {
        var cards = [Card]()
        
        for index in 0 ..< pairsCount {
            let pair = [
                Card(content: contentProvider(index)),
                Card(content: contentProvider(index))
            ]
            cards.append(contentsOf: pair)
        }
        
        self.cards = cards.shuffled()
    }
}

// MARK: - Choosing Cards

extension Memorize {
    private var unmatchedCards: [Card] {
        cards.filter { !$0.isMatched }
    }
    
    mutating func chooseCard(atIndex index: Int) {
        var card = cards[index]
        
        guard !card.isMatched else {
            return
        }
        
        if let pair = faceUpPair {
            guard isIndex(index, outOf: pair) else {
                return
            }
            
            match(pair)
        }
        
        if card.isFaceUp {
            penalizeUserForFlipping(card)
        }
        
        card.isFaceUp.toggle()
        cards[index] = card
        
        if let pair = faceUpPair, isLastPairBeingMatched {
            match(pair)
        }
    }
}

// MARK: - Matching Cards

private extension Memorize {
    mutating func match(_ pair: Pair) {
        let isAMatch = pair.first.content == pair.second.content
        
        if isAMatch {
            scoreMatch()
        } else {
            scoreMismatch(for: pair.first, pair.second)
        }
        
        let pairIndexes = indexes(from: pair)
        
        [pairIndexes.first, pairIndexes.second].forEach {
            cards[$0].isMatched = isAMatch
            cards[$0].isFaceUp = isAMatch
        }
    }
}

// MARK: - Score

private extension Memorize {
    mutating func scoreMatch() {
        score += 2
    }
    
    mutating func scoreMismatch(for cards: Card...) {
        for card in cards {
            if viewedCards.contains(card) {
                score -= 1
            }
            
            viewedCards.insert(card)
        }
    }
    
    mutating func penalizeUserForFlipping(_ card: Card) {
        score -= 1
        viewedCards.insert(card)
    }
}

// MARK: - Pair helpers

private extension Memorize {
    
    typealias Pair = (first: Card, second: Card)
    typealias PairIndexes = (first: Int, second: Int)
    
    private var isLastPairBeingMatched: Bool {
        unmatchedCards.count == 2
    }
    
    private var faceUpPair: Pair? {
        let faceUpCards = unmatchedCards.filter { $0.isFaceUp }
        
        guard faceUpCards.count == 2 else {
            return nil
        }
        
        return (first: faceUpCards[0], second: faceUpCards[1])
    }
    
    private func indexes(from pair: Pair) -> PairIndexes {
        guard let firstIndex = cards.firstIndex(of: pair.first),
              let secondIndex = cards.firstIndex(of: pair.second) else {
                  preconditionFailure("The provided pair should have valid indexes in its cards.")
              }
        
        return (firstIndex, secondIndex)
    }
    
    private func isIndex(_ index: Int, outOf pair: Pair) -> Bool {
        let pairIndexes = indexes(from: pair)
        return index != pairIndexes.first && index != pairIndexes.second
    }
}
