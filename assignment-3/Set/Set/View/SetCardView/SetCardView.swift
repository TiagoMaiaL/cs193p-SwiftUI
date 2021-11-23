//
//  SetCardView.swift
//  Set
//
//  Created by Tiago Lopes on 06/11/21.
//

import SwiftUI

// MARK: - Card View

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
            .contentShape(Rectangle())
        }
    }
}

// MARK: Background

private extension SetCardView {
    func background(with size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                .foregroundColor(backgroundColor)
            
//            RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
//                .stroke(lineWidth: size.width * Constants.Background.borderLengthFactor)
//                .foregroundColor(.gray)
        }
    }
    
    var backgroundColor: Color {
        if viewModel.isMatched {
            return Constants.Colors.matched
        }
        
        if viewModel.isUnmatched {
            return Constants.Colors.unmatched
        }
        
        if viewModel.isSelected {
            return .white //Constants.Colors.selected
        }
        
        return Colors.cardBackground //Constants.Colors.default
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
            width: size.width * Constants.DrawingFactors.width,
            height: size.height * Constants.DrawingFactors.height
        )
    }
    private var verticalSpacing: Double {
        availableDrawingSize.height * Constants.DrawingFactors.verticalShapesSpacing
    }
    private var itemHeight: Double {
        (availableDrawingSize.height / 3) - (2 * verticalSpacing)
    }
    
    private var shapeColor: Color {
        viewModel
            .color
        // TODO: Draw the correct striped shape.
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
        let strokeWidth = itemHeight * Constants.DrawingFactors.shapeStroke
        
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

// MARK: - Constants

fileprivate enum Constants {
    enum Background {
        static let cornerRadius = 10.0
        static let borderLengthFactor = 0.01
    }
    
    enum Colors {
        static let `default` = Color.clear
        static let matched = Color.yellow
        static let unmatched = Color.red.opacity(0.4)
        static let selected = Color.gray.opacity(0.5)
    }
    
    enum DrawingFactors {
        static let width = 0.7
        static let height = 0.6
        static let verticalShapesSpacing = 0.05
        static let shapeStroke = 0.04
    }
}

// MARK: - Preview

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        blueOvalsThreeSolidCard
        redSquigglesThreeStriped
        greenDiamondsThreeStroked
    }
    
    static var blueOvalsThreeSolidCard: some View {
        let card = Card(
            color: .first,
            shape: .first,
            count: .three,
            shading: .first
        )
        let viewModel = SetCardViewModel(card)
        
        return SetCardView(viewModel: viewModel)
            .padding()
    }
    
    static var redSquigglesThreeStriped: some View {
        let card = Card(
            color: .second,
            shape: .second,
            count: .three,
            shading: .second
        )
        let viewModel = SetCardViewModel(card)
        
        return SetCardView(viewModel: viewModel)
            .padding()
    }
    
    static var greenDiamondsThreeStroked: some View {
        let card = Card(
            color: .third,
            shape: .third,
            count: .three,
            shading: .third
        )
        let viewModel = SetCardViewModel(card)
        
        return SetCardView(viewModel: viewModel)
            .padding()
    }
}
