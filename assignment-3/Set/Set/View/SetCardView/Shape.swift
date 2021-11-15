//
//  Shape.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import Foundation

enum Shape {
    case oval
    case squiggle
    case diamond
}

extension Shape: CustomStringConvertible {
    var description: String {
        switch self {
        case .oval:
            return "Oval"
            
        case .squiggle:
            return "Squiggle"
            
        case .diamond:
            return "Diamond"
        }
    }
}
