//
//  DealButtonStyle.swift
//  Set
//
//  Created by Tiago Lopes on 21/11/21.
//

import SwiftUI

// MARK: - Button Style

struct DealButtonStyle: ButtonStyle {
    
    // MARK: Properties
    
    @Environment(\.isEnabled)
    var isEnabled
    
    // MARK: Body
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding()
            .background {
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: proxy.size.height / 2)
                        .foregroundColor(backgroundColor(for: configuration))
                }
            }
    }
    
    private func backgroundColor(for configuration: Configuration) -> Color {
        guard isEnabled else {
            return .black.opacity(0.2)
        }
        
        return configuration.isPressed ? .green.opacity(0.4) : .green
    }
}

// MARK: - Static Member

extension ButtonStyle where Self == DealButtonStyle {
    static var deal: DealButtonStyle {
        DealButtonStyle()
    }
}

// MARK: - Preview

struct DealButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button("Deal cards", action: {})
            .buttonStyle(.deal)
        
        Button("Deal cards", action: {})
            .disabled(true)
            .buttonStyle(.deal)
    }
}
