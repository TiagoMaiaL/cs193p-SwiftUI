//
//  Theme.swift
//  Memorize
//
//  Created by Tiago Lopes on 07/07/21.
//

import Foundation

struct Theme<Content> where Content: Equatable {
    
    // MARK: Properties
    
    let name: String
    let pairsCount: Int
    let options: [Content]
    let color: Color
    var shuffledOptions: [Content] {
        Array(options.shuffled().prefix(pairsCount))
    }
    
    // MARK: Initializer
    
    init(name: String, pairsCount: Int? = nil, options: [Content], color: Color) {
        assert(options.count >= 2, "The number of options should be greater than 1.")
        
        self.name = name
        
        // Extra-credit 1
        if let pairsCount = pairsCount {
            self.pairsCount = min(pairsCount, options.count)
        } else {
            self.pairsCount = options.count
        }
        
        self.options = options
        self.color = color
    }
    
    init(name: String, options: [Content], color: Color, maxRandomPairs: Int) {
        assert(maxRandomPairs <= options.count, "maxRandomPairs should be smaller or equals to the number of options.")
        assert(maxRandomPairs >= 2, "The minimum allowed number of pairs is 2.")
        
        // Extra-credit 2
        let maxPairs = min(options.count, maxRandomPairs)
        let randomPairsCount = Int.random(in: 2 ... maxPairs)
        
        self.init(
            name: name,
            pairsCount: randomPairsCount,
            options: options,
            color: color
        )
    }
}
