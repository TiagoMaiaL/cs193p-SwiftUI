//
//  OvalView.swift
//  Set
//
//  Created by Tiago Lopes on 06/12/21.
//

import SwiftUI

// MARK: - View

struct OvalView: View {
    
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
                    OvalShape()
                        .fill()
                        .mask(StripedShading())
                    
                    OvalShape()
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
                OvalShape()
                
            case .stroked:
                OvalShape()
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

struct OvalView_Previews: PreviewProvider {
    static var previews: some View {
        OvalView(height: 100, color: .blue, shading: .solid)
            .padding()
        
        OvalView(height: 100, color: .blue, shading: .striped)
            .padding()
        
        OvalView(height: 100, color: .blue, shading: .stroked)
            .padding()
    }
}
