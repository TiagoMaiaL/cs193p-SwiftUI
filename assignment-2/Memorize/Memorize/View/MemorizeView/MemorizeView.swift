//
//  MemorizeView.swift
//  Memorize
//
//  Created by Tiago Lopes on 28/06/21.
//

import SwiftUI

// MARK: - View

struct MemorizeView: View {
    
    // MARK: Properties
    
    @StateObject
    var viewModel = EmojiMemorizeViewModel()
    
    // MARK: Body
    
    var body: some View {
        VStack {
            titleViews
            
            CardsGridView(
                cards: viewModel.cards,
                cardsColor: viewModel.themeColor,
                cardTapHandler: viewModel.choose
            )
            
            Spacer()
            
            footer
        }
    }
    
    private var titleViews: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Text("Memorize!")
                .font(.title)
            
            Text(viewModel.themeName)
                .font(.headline)
                .foregroundColor(viewModel.themeColor)
        }.padding(Constants.headerPaddingInsets)
    }
    
    private var footer: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Button("New game") {
                viewModel.startNewGame()
            }
            
            Text("Score: \(viewModel.score)")
                .font(.callout)
        }
        .padding()
    }
}

// MARK: Constants

private extension MemorizeView {
    enum Constants {
        static let verticalSpacing = 5.0
        static let headerPaddingInsets = EdgeInsets(top: 20.0, leading: 0, bottom: 0, trailing: 0)
    }
}

// MARK: - Preview

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
