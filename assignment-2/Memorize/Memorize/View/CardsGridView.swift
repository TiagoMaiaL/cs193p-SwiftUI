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
    
    // MARK: Initializer
    
    init(cards cardsViewModels: [EmojiCardViewModel], cardsColor: Color) {
        self.cardsViewModels = cardsViewModels
        self.cardsColor = cardsColor
    }
    
    // MARK: Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Constants.adaptiveColumn) {
                ForEach(cardsViewModels) {
                    CardView(viewModel: $0, color: cardsColor)
                        .aspectRatio(Constants.cardAspectRatio, contentMode: .fit)
                }
            }
            .padding()
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
