//
//  SetGameView.swift
//  Set
//
//  Created by Tiago Lopes on 08/10/21.
//

import SwiftUI

// MARK: - Set Game View

struct SetGameView: View {
    
    // MARK: Properties
    
    @StateObject
    var viewModel = SetGameViewModel()
    
    @State
    var tabHeight: Double?
    
    // MARK: Body
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                // TODO: Measure the application performance.
                // TODO: Test this app on a real device.
                ScrollableAspectVGrid(
                    items: viewModel.cards,
                    aspectRatio: Constants.cardsApectRatio,
                    minimumWidth: Constants.cardMinimumWidth,
                    interitemSpacing: Constants.interitemSpacing,
                    bottomEdgeInset: tabHeight,
                    horizontalPadding: Constants.horizontalPadding
                ) { card in
                    SetCardView(viewModel: card)
                        .onTapGesture {
                            viewModel.choose(card)
                        }
                }
                
                VStack {
                    Spacer()
                    GameControlsTab(
                        viewModel: viewModel,
                        safeBottomInset: proxy.safeAreaInsets.bottom
                    ).background {
                        GeometryReader { tabProxy in
                            Color.clear.onAppear {
                                tabHeight = tabProxy.size.height
                            }
                        }
                    }
                }
            }
            .ignoresSafeArea(.all, edges: .bottom)
        }
    }
}

// MARK: - Constants

fileprivate enum Constants {
    static let cardsApectRatio = 2.0/3.0
    static let cardMinimumWidth = 75.0
    static let interitemSpacing = 10.0
    static let horizontalPadding = 20.0
}

// MARK: - Preview

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
