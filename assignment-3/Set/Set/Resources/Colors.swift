//
//  Colors.swift
//  Set
//
//  Created by Tiago Lopes on 22/11/21.
//

import SwiftUI

// MARK: Application Colors

// TODO: Provide the dark variation of the application colors.

struct Colors {
    static let gameBackground = Color.tertiarySystemGroupedBackground
    
    static let cardBorder = Color.systemGray
    static let cardBackground = Color.systemBackground
    static let cardUnmatchedBackground = Color.systemRed.opacity(0.2)
    static let cardMatchedBackground = Color.systemYellow.opacity(0.2)
    static let cardSelectedBackground = Color.systemBlue.opacity(0.1)
    
    static let shapePurple = Color.systemPurple
    static let shapeGreen = Color.systemGreen
    static let shapeRed = Color.systemRed
    
    static let dealButtonBackground = Color(uiColor: .tintColor)
    static let newGameButtonBackground = Color(uiColor: .systemBackground)
}

// MARK: System Colors

extension Color {
    static let systemBackground = Color(uiColor: .systemBackground)
    static let tertiarySystemGroupedBackground = Color(uiColor: .tertiarySystemGroupedBackground)
    
    static let tintColor = Color(uiColor: .tintColor)
    
    static let systemPurple = Color(uiColor: .systemPurple)
    static let systemGreen = Color(uiColor: .systemGreen)
    static let systemRed = Color(uiColor: .systemRed)
    static let systemYellow = Color(uiColor: .systemYellow)
    static let systemBlue = Color(uiColor: .systemBlue)
    
    static let systemGray = Color(uiColor: .systemGray)
}
