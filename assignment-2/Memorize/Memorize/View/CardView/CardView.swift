//
//  CardView.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import SwiftUI

// MARK: - View

struct CardView: View {
    
    // MARK: Properties
    
    let viewModel: EmojiCardViewModel
    let color: Color
    let tapHandler: ((EmojiCardViewModel) -> Void)?
    
    // MARK: Initializer
    
    init(
        viewModel: EmojiCardViewModel,
        color: Color,
        tapHandler: ((EmojiCardViewModel) -> Void)? = nil
    ) {
        self.viewModel = viewModel
        self.color = color
        self.tapHandler = tapHandler
    }
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Group {
                    if viewModel.isFaceUp {
                        rectangle
                            .stroke(colorGradient, lineWidth: Constants.borderWidth)
                        Text(viewModel.content)
                            .font(.based(on: proxy))
                    } else {
                        rectangle
                            .fill(colorGradient)
                    }
                }
                .foregroundColor(color)
                .contentShape(rectangle)
                .opacity(viewModel.isMatched ? Constants.matchedOpacity : Constants.unmatchedOpacity)
                .onTapGesture { tapHandler?(viewModel) }
            }
        }
    }
    
    private var rectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: Constants.rectangleRadius)
    }
    
    // Extra-credit 3
    private var colorGradient: LinearGradient {
        LinearGradient(
            colors: [color, color.opacity(Constants.endGradientOpacity)],
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
}

// MARK: Constants

private extension CardView {
    enum Constants {
        static let rectangleRadius = 10.0
        static let borderWidth = 2.0
        static let matchedOpacity = 0.0
        static let unmatchedOpacity = 1.0
        static let endGradientOpacity = 0.7
    }
}

// MARK: - Font extension

fileprivate extension Font {
    static func based(on proxy: GeometryProxy) -> Font {
        let minDimension = min(proxy.size.width, proxy.size.height)
        return .system(size: minDimension * 0.8)
    }
}

// MARK: - Preview

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        facedDownPreview
        facedUpPreview
        matchedPreview
    }
    
    static var facedDownPreview: some View {
        let card = Memorize<Emoji>.Card(id: "facedDown", content: "🍎", isFaceUp: false, isMatched: false)
        let viewModel = EmojiCardViewModel(card: card)
        return CardView(viewModel: viewModel, color: .red)
    }
    
    static var facedUpPreview: some View {
        let card = Memorize<Emoji>.Card(id: "facedUp", content: "🍎", isFaceUp: true, isMatched: false)
        let viewModel = EmojiCardViewModel(card: card)
        return CardView(viewModel: viewModel, color: .red)
    }
    
    static var matchedPreview: some View {
        let card = Memorize<Emoji>.Card(id: "matched", content: "🍎", isFaceUp: true, isMatched: true)
        let viewModel = EmojiCardViewModel(card: card)
        return CardView(viewModel: viewModel, color: .red)
    }
}
