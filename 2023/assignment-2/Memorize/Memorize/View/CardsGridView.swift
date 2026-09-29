//
//  CardsGridView.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import SwiftUI

// MARK: - View

struct CardsGridView: View {
    
    // MARK: Properties
    
    let cardsViewModels: [EmojiCardViewModel]
    let cardsColor: Color
    let cardTapHandler: ((EmojiCardViewModel) -> Void)?
    
    // MARK: Initializer
    
    init(
        cards cardsViewModels: [EmojiCardViewModel],
        cardsColor: Color,
        cardTapHandler: ((EmojiCardViewModel) -> Void)? = nil
    ) {
        self.cardsViewModels = cardsViewModels
        self.cardsColor = cardsColor
        self.cardTapHandler = cardTapHandler
    }
    
    // MARK: Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Constants.adaptiveColumn) {
                ForEach(cardsViewModels) { cardViewModel in
                    CardView(
                        viewModel: cardViewModel,
                        color: cardsColor,
                        tapHandler: cardTapHandler
                    )
                    .aspectRatio(Constants.cardAspectRatio, contentMode: .fit)
                    .animation(.easeInOut, value: cardViewModel)
                }
            }
            .padding()
            .animation(.easeInOut, value: [cardsViewModels])
        }
    }
}

// MARK: - Constants

private extension CardsGridView {
    enum Constants {
        static let adaptiveColumn = [GridItem(.adaptive(minimum: 85))]
        static let cardAspectRatio = 3.0/4.0
    }
}

// MARK: - Preview

struct CardsGridView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = EmojiMemorizeViewModel()
        return CardsGridView(cards: viewModel.cards, cardsColor: .green)
    }
}
