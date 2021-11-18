//
//  SetCardView.swift
//  Set
//
//  Created by Tiago Lopes on 06/11/21.
//

import SwiftUI

// MARK: - Card View

// TODO: Add the constants to this view.

struct SetCardView: View {
    
    // MARK: Properties
    
    let viewModel: SetCardViewModel
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background(with: geometry.size)
                Shapes(viewModel: viewModel, size: geometry.size)
            }
        }
    }
}

// MARK: Background

private extension SetCardView {
    func background(with size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(backgroundColor)
            
            RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: size.width * 0.01)
                .foregroundColor(.gray)
        }
    }
    
    var backgroundColor: Color {
        if viewModel.isMatched {
            return .yellow
        }
        
        if viewModel.isUnmatched {
            return .red.opacity(0.4)
        }
        
        if viewModel.isSelected {
            return .gray.opacity(0.5)
        }
        
        return .clear
    }
}

// MARK: Shapes

fileprivate struct Shapes: View {
    
    // MARK: Properties
    
    let viewModel: SetCardViewModel
    
    let size: CGSize
    private lazy var center = CGPoint(
        x: size.width / 2,
        y: size.height / 2
    )
    
    private var availableDrawingSize: CGSize {
        CGSize(
            width: size.width * 0.75,
            height: size.height * 0.65
        )
    }
    private var verticalSpacing: Double {
        availableDrawingSize.height * 0.03
    }
    private var itemHeight: Double {
        (availableDrawingSize.height / 3) - (2 * verticalSpacing)
    }
    
    private var shapeColor: Color {
        viewModel
            .color
            .opacity(viewModel.shading == .striped ? 0.4 : 1)
    }
    
    // MARK: Init
    
    init(viewModel: SetCardViewModel, size: CGSize) {
        self.viewModel = viewModel
        self.size = size
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: verticalSpacing) {
            ForEach(0 ..< viewModel.count, id: \.self) { _ in
                cardShape
                    .foregroundColor(shapeColor)
                    .frame(
                        width: availableDrawingSize.width,
                        height: itemHeight,
                        alignment: .center
                    )
            }
        }
        .frame(
            width: availableDrawingSize.width,
            height: availableDrawingSize.height,
            alignment: .center
        )
    }
    
    @ViewBuilder
    private var cardShape: some View {
        let strokeWidth = itemHeight * 0.04
        
        switch viewModel.shape {
        case .diamond:
            if viewModel.shading == .stroked {
                DiamondShape().stroke(lineWidth: strokeWidth)
            } else {
                DiamondShape()
            }
            
        case .oval:
            if viewModel.shading == .stroked {
                OvalShape().stroke(lineWidth: strokeWidth)
            } else {
                OvalShape()
            }

        case .squiggle:
            if viewModel.shading == .stroked {
                SquiggleShape().stroke(lineWidth: strokeWidth)
            } else {
                SquiggleShape()
            }
        }
    }
}

// MARK: - Preview

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(
            color: .first,
            shape: .first,
            count: .three,
            shading: .second
        )
        let viewModel = SetCardViewModel(card)
        
        return SetCardView(viewModel: viewModel)
            .padding()
    }
}

// TODO: Provide varied previews.
