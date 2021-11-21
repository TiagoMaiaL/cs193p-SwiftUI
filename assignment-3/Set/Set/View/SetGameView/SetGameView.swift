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
        ZStack {
            // TODO: Measure the application performance.
            // TODO: Test this app on a real device.
            ScrollableAspectVGrid(
                items: viewModel.cards,
                aspectRatio: Constants.cardsApectRatio,
                minimumWidth: Constants.cardMinimumWidth,
                interitemSpacing: Constants.interitemSpacing
            ) { card in
                SetCardView(viewModel: card)
                    .onTapGesture {
                        viewModel.choose(card)
                    }
            }
            
            BottomButtonsTab(viewModel: viewModel)
        }
        .ignoresSafeArea(.all, edges: .bottom)
    }
}

// MARK: - Background

fileprivate struct BottomButtonsTab: View {
    
    // MARK: Properties
    
    @ObservedObject
    var viewModel: SetGameViewModel
    
    // MARK: Body
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack {
                Button("New Game") {
                    viewModel.startNewGame()
                }
                .padding()
                
                Spacer()
                
                Button("Deal") {
                    viewModel.deal()
                }
                .disabled(!viewModel.canDeal)
                .padding()
            }
            .padding()
            .background(.thinMaterial)
        }
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let cardsApectRatio = 2.0/3.0
    static let cardMinimumWidth = 75.0
    static let interitemSpacing = 5.0
}

// MARK: - Preview

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
