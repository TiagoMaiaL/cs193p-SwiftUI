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
    private func background(with size: CGSize) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                .foregroundStyle(backgroundStyle)
            
            RoundedRectangle(cornerRadius: Constants.Background.cornerRadius)
                .stroke(lineWidth: size.width * Constants.Background.borderLengthFactor)
                .foregroundColor(Colors.cardBorder)
        }
    }
    
    private var backgroundStyle: LinearGradient {
        var startColor = Colors.cardBackground
        var endColor = startColor
        
        if viewModel.isUnmatched {
            startColor = Colors.cardUnmatchedBackground
            
        } else if viewModel.isMatched {
            startColor = Colors.cardMatchedBackground
            
        } else if viewModel.isSelected {
            startColor = Colors.cardSelectedBackground
        }
        
        if startColor != Colors.cardBackground {
            endColor = startColor.opacity(0.5)
        }
        
        return LinearGradient(
            colors: [startColor, endColor],
            startPoint: .bottom,
            endPoint: .top
        )
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
    
    // MARK: Initializer
    
    init(viewModel: SetCardViewModel, size: CGSize) {
        self.viewModel = viewModel
        self.size = size
    }
    
    // MARK: Body
    
    var body: some View {
        VStack(spacing: verticalSpacing) {
            ForEach(0 ..< viewModel.count, id: \.self) { _ in
                cardShape
                // TODO: Remove this from here and pass it to the shape.
                    .foregroundColor(viewModel.color)
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
            DiamondView(
                height: itemHeight,
                color: viewModel.color,
                shading: viewModel.shading
            )
            
        case .oval:
            OvalView(
                height: itemHeight,
                color: viewModel.color,
                shading: viewModel.shading
            )
            
        case .squiggle:
            if viewModel.shading == .stroked {
                SquiggleShape()
                    .stroke(lineWidth: strokeWidth)
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
        static let borderLengthFactor = 0.005
    }
    
    enum Colors {
        static let matched = Color.yellow
        static let unmatched = Color.red.opacity(0.4)
    }
    
    enum DrawingFactors {
        static let width = 0.7
        static let height = 0.8
        static let verticalShapesSpacing = 0.06
        static let shapeStroke = 0.1
    }
}

// MARK: - Preview

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        blueOvalsThreeSolidCard
        redSquigglesThreeStriped
        greenDiamondsThreeStrided
    }
    
    static var blueOvalsThreeSolidCard: some View {
        var card = Card(
            color: .first,
            shape: .first,
            count: .three,
            shading: .first
        )
        card.isSelected = true
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
    
    static var greenDiamondsThreeStrided: some View {
        let card = Card(
            color: .third,
            shape: .third,
            count: .three,
            shading: .second
        )
        let viewModel = SetCardViewModel(card)
        
        return SetCardView(viewModel: viewModel)
            .padding()
    }
}
