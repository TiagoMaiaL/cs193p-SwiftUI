//
//  DiamondView.swift
//  Set
//
//  Created by Tiago Lopes on 04/12/21.
//

import SwiftUI

// MARK: - View

struct DiamondView: View {
    
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
                    DiamondShape()
                        .fill()
                        .mask(StripedShading())
                    
                    DiamondShape()
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
                DiamondShape()
                
            case .stroked:
                DiamondShape()
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

struct DiamondView_Previews: PreviewProvider {
    static var previews: some View {
        DiamondView(height: 100, color: .red, shading: .solid)
            .padding()
        
        DiamondView(height: 100, color: .red, shading: .striped)
            .padding()
        
        DiamondView(height: 100, color: .red, shading: .stroked)
            .padding()
    }
}
