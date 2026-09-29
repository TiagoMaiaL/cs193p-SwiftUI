//
//  ThemeColor+SwiftUIColor.swift
//  Memorize
//
//  Created by Tiago Lopes on 16/07/21.
//

import SwiftUI

extension Theme.Color {
    var userInterfaceColor: SwiftUI.Color {
        switch self {
        case .green:
            return SwiftUI.Color.green
            
        case .red:
            return SwiftUI.Color.red
            
        case .gray:
            return SwiftUI.Color.gray
            
        case .purple:
            return SwiftUI.Color.purple
            
        case .yellow:
            return SwiftUI.Color.yellow
            
        case .blue:
            return SwiftUI.Color.blue
        }
    }
}
