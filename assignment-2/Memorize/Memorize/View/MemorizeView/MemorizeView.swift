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
            header
            
            CardsGridView(
                cards: viewModel.cards,
                cardsColor: viewModel.themeColor,
                cardTapHandler: viewModel.choose
            )
            
            Spacer()
            
            Button("New game") {
                viewModel.startNewGame()
            }
            .padding()
        }
    }
    
    private var header: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Text("Memorize!")
                .font(.title)
            
            Text(viewModel.themeName)
                .font(.headline)
                .foregroundColor(viewModel.themeColor)
        }.padding(Constants.headerPaddingInsets)
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
