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
            .foregroundColor(.white)
            .padding()
            .background {
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: proxy.size.height / 2)
                        .foregroundColor(configuration.isPressed ? .red.opacity(0.4) : .red)
                }
            }
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
