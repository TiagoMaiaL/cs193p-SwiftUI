//
//  DiamondView.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import SwiftUI

struct DiamondView: View {
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                path.move(
                    to: CGPoint(
                        x: 0,
                        y: geometry.size.height / 2
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: geometry.size.width / 2,
                        y: geometry.size.height
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: geometry.size.width,
                        y: geometry.size.height / 2
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: geometry.size.width / 2,
                        y: 0
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: geometry.size.width / 2,
                        y: 0
                    )
                )
                path.addLine(
                    to: CGPoint(
                        x: 0,
                        y: geometry.size.height / 2
                    )
                )
            }
        }
    }
}

struct DiamondShape_Previews: PreviewProvider {
    static var previews: some View {
        DiamondView()
            .padding()
    }
}
