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
        self.name = name
        
        if let pairsCount = pairsCount {
            self.pairsCount = min(pairsCount, options.count)
        } else {
            self.pairsCount = options.count
        }
        
        self.options = options
        self.color = color
    }
}

// TODO: Add a namespace for Emoji themes.
