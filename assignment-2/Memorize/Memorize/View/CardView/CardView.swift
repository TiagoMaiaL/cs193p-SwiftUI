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
    
    @State var isFaceUp = true
    var viewModel: EmojiCardViewModel
    // TODO: Receive the card color.
    
    // MARK: Initializer
    
    init(_ cardViewModel: EmojiCardViewModel) {
        viewModel = cardViewModel
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
            .foregroundColor(.green)
            .contentShape(rectangle)
            .onTapGesture {
                // TODO: Inform the view model of this tap.
                isFaceUp.toggle()
            }
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
    }
}

// MARK: - Preview

struct CardView_Previews: PreviewProvider {
    // TODO: Have two previews here: one for face up, other for face down.
    static var previews: some View {
        let viewModel = EmojiMemorizeViewModel()
        CardView(viewModel.cards[0])
    }
}
