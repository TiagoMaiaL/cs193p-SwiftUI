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
    // TDOO: Provide the color to the card.
    
    // MARK: Initializer
    
    init(_ cardsViewModels: [EmojiCardViewModel]) {
        self.cardsViewModels = cardsViewModels
    }
    
    // MARK: Body
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: Constants.adaptiveColumn) {
                ForEach(cardsViewModels) { cardViewModel in
                    // TODO: Provide the color here.
                    CardView(cardViewModel)
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
        return CardsGridView(viewModel.cards)
    }
}
