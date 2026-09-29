//
//  Shading.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import Foundation

enum Shading {
    case solid
    case striped
    case stroked
}

extension Shading: CustomStringConvertible {
    var description: String {
        switch self {
        case .solid:
            return "Solid"
            
        case .striped:
            return "Striped"
            
        case .stroked:
            return "Stroked"
        }
    }
}
