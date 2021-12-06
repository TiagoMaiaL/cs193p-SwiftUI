//
//  SquiggleShape.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import SwiftUI

struct SquiggleShape: SwiftUI.Shape {
    func path(in rect: CGRect) -> Path {
        Path { path in
            path.addRect(rect)
        }
    }
}

struct SquiggleShape_Previews: PreviewProvider {
    static var previews: some View {
        SquiggleShape()
            .padding()
    }
}
