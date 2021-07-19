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
        ZStack {
            Group {
                if viewModel.isFaceUp {
                    rectangle
                        .stroke(lineWidth: Constants.borderWidth)
                    Text(viewModel.content)
                        .font(.system(size: Constants.textFontSize))
                } else {
                    rectangle
                }
            }
            .foregroundColor(color)
            .contentShape(rectangle)
            .opacity(viewModel.isMatched ? Constants.matchedOpacity : Constants.unmatchedOpacity)
            .onTapGesture { tapHandler?(viewModel) }
        }
    }
    
    private var rectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: Constants.rectangleRadius)
    }
}

// MARK: Constants

private extension CardView {
    enum Constants {
        static let rectangleRadius = 10.0
        static let borderWidth = 2.0
        static let textFontSize = 40.0
        static let matchedOpacity = 0.2
        static let unmatchedOpacity = 1.0
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
        let card = Card(content: "🍎", isFaceUp: false, isMatched: false)
        let viewModel = EmojiCardViewModel(card: card)
        return CardView(viewModel: viewModel, color: .red)
    }
    
    static var facedUpPreview: some View {
        let card = Card(content: "🍎", isFaceUp: true, isMatched: false)
        let viewModel = EmojiCardViewModel(card: card)
        return CardView(viewModel: viewModel, color: .red)
    }
    
    static var matchedPreview: some View {
        let card = Card(content: "🍎", isFaceUp: true, isMatched: true)
        let viewModel = EmojiCardViewModel(card: card)
        return CardView(viewModel: viewModel, color: .red)
    }
}
