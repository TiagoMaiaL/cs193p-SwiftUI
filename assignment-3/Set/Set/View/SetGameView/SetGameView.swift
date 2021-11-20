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
            // TODO: Measure the application performance.
            // TODO: Test this app on a real device.
            ScrollableAspectVGrid(
                items: viewModel.cards,
                aspectRatio: 2/3,
                minimumWidth: 75,
                interitemSpacing: 5
            ) { card in
                SetCardView(viewModel: card)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            
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
