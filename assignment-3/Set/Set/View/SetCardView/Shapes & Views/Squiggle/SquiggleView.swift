//
//  SquiggleView.swift
//  Set
//
//  Created by Tiago Lopes on 06/12/21.
//

import SwiftUI

// MARK: - View

struct SquiggleView: View {
    
    // MARK: Properties
    
    let height: Double
    let color: Color
    let shading: Shading
    private var strokeWidth: Double {
        height * Constants.shapeStroke
    }
  
    // MARK: Initializer
    
    init(height: Double, color: Color, shading: Shading) {
        self.height = height
        self.color = color
        self.shading = shading
    }
    
    // MARK: Body
    
    var body: some View {
        Group {
            switch shading {
            case .striped:
                ZStack {
                    SquiggleShape()
                        .fill()
                        .mask(StripedShading())
                    
                    SquiggleShape()
                        .stroke(
                            style: StrokeStyle(
                                lineWidth: strokeWidth,
                                lineCap: .round,
                                lineJoin: .round,
                                miterLimit: 0,
                                dash: [],
                                dashPhase: 0
                            )
                        )
                }
                
            case .solid:
                SquiggleShape()
                
            case .stroked:
                SquiggleShape()
                    .stroke(
                        style: StrokeStyle(
                            lineWidth: strokeWidth,
                            lineCap: .round,
                            lineJoin: .round,
                            miterLimit: 0,
                            dash: [],
                            dashPhase: 0
                        )
                    )
            }
        }
        .foregroundColor(color)
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let shapeStroke = 0.1
}
    
// MARK: - Preview

struct SquiggleView_Previews: PreviewProvider {
    static var previews: some View {
        SquiggleView(height: 100, color: .green, shading: .solid)
            .padding()
        
        SquiggleView(height: 100, color: .green, shading: .striped)
            .padding()
        
        SquiggleView(height: 100, color: .green, shading: .stroked)
            .padding()
    }
}
