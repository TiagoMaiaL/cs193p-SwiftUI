//
//  DiamondShape.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import SwiftUI

// MARK: DiamondShape

struct DiamondShape: SwiftUI.Shape {
    
    // MARK: Path
    
    func path(in rect: CGRect) -> Path {
        let width = rect.size.width
        let height = rect.size.height
        
        return Path { path in
            path.move(
                to: CGPoint(
                    x: 0,
                    y: height / 2
                )
            )
            path.addLine(
                to: CGPoint(
                    x: width / 2,
                    y: height
                )
            )
            path.addLine(
                to: CGPoint(
                    x: width,
                    y: height / 2
                )
            )
            path.addLine(
                to: CGPoint(
                    x: width / 2,
                    y: 0
                )
            )
            path.addLine(
                to: CGPoint(
                    x: width / 2,
                    y: 0
                )
            )
            path.addLine(
                to: CGPoint(
                    x: 0,
                    y: height / 2
                )
            )
        }
    }
}

// MARK: Preview

struct DiamondShape_Previews: PreviewProvider {
    static var previews: some View {
        DiamondShape()
            .padding()
    }
}
