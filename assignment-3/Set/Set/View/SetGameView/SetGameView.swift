//
//  SetGameView.swift
//  Set
//
//  Created by Tiago Lopes on 08/10/21.
//

import SwiftUI

// MARK: - View

struct SetGameView: View {
    
    // MARK: Properties
    
    @StateObject
    var viewModel = SetGameViewModel()
    
    // MARK: Body
    
    var body: some View {
        VStack {
            AspectVGrid(
                items: viewModel.cards,
                aspectRatio: 3/4
            ) { card in
                SetCardView(viewModel: card)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            .padding()
            
            HStack {
                Button("New Game") {
                    viewModel.startNewGame()
                }
                .padding()
                
                Button("Deal") {
                    viewModel.deal()
                }
                .disabled(!viewModel.canDeal)
                .padding()
            }
        }
    }
}

// MARK: - Preview

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
