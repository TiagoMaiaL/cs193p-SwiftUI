//
//  DealButtonStyle.swift
//  Set
//
//  Created by Tiago Lopes on 21/11/21.
//

import SwiftUI

// MARK: - Button Style

struct DealButtonStyle: ButtonStyle {
    
    // MARK: Body
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .foregroundColor(.white)
            .padding()
            .background {
                GeometryReader { proxy in
                    RoundedRectangle(cornerRadius: proxy.size.height / 2)
                        .foregroundColor(.green)
                }
            }
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
    }
}
