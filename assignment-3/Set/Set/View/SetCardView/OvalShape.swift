//
//  OvalShape.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import SwiftUI

// MARK: - OvalShape

struct OvalShape: SwiftUI.Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addRoundedRect(
                in: rect,
                cornerSize: CGSize(
                    width: rect.width,
                    height: rect.width
                )
            )
        }
    }
}

// MARK: - Preview

struct OvalView_Previews: PreviewProvider {
    static var previews: some View {
        OvalShape()
            .padding()
    }
}
