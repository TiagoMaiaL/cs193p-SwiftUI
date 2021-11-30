//
//  StripedShading.swift
//  Set
//
//  Created by Tiago Lopes on 30/11/21.
//

import SwiftUI

struct StripedShading: SwiftUI.Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.move(to: .zero)
            let spacing = 10.0
            var currentX = 0.0 {
                didSet {
                    path.move(to: CGPoint(x: currentX, y: 0))
                }
            }
            
            while currentX < rect.size.width {
                path.addLine(to: CGPoint(x: currentX, y: rect.maxY))
                currentX += spacing
            }
        }
        .strokedPath(
            StrokeStyle(
                lineWidth: 2,
                lineCap: CGLineCap.round,
                lineJoin: CGLineJoin.round,
                miterLimit: 0,
                dash: [],
                dashPhase: 0
            )
        )
    }
}

struct StripedShading_Previews: PreviewProvider {
    static var previews: some View {
        StripedShading()
    }
}
