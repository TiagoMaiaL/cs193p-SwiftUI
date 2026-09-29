//
//  NewGameButtonStyle.swift
//  Set
//
//  Created by Tiago Lopes on 21/11/21.
//

import SwiftUI

// MARK: - Button Style

struct NewGameButtonStyle: ButtonStyle {
    
    // MARK: Body
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(Colors.newGameButtonFontColor)
            .padding()
            .background {
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: proxy.size.height / 2)
                        .foregroundColor(Colors.newGameButtonBackground)
                }
            }
            .opacity(configuration.isPressed ? 0.4 : 1)
    }
}

// MARK: - Static Member

extension ButtonStyle where Self == NewGameButtonStyle {
    static var newGame: NewGameButtonStyle {
        NewGameButtonStyle()
    }
}

// MARK: - Preview

struct NewGameButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("New Game", action: {})
            .buttonStyle(.newGame)
    }
}
