//
//  Memorize+Theme.swift
//  Memorize
//
//  Created by Tiago Lopes on 08/07/21.
//

import Foundation

extension Memorize {
    
    // MARK: Initializer
    
    init(theme: Theme<Content>) {
        let options = theme.shuffledOptions
        self.init(pairsCount: theme.pairsCount, contentProvider: { options[$0] })
    }
}
