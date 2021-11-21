//
//  GameControlsTab.swift
//  Set
//
//  Created by Tiago Lopes on 21/11/21.
//

import SwiftUI

// MARK: - GameControlsTab

struct GameControlsTab: View {
    
    // MARK: Properties
    
    @ObservedObject
    var viewModel: SetGameViewModel
    
    let safeBottomInset: Double?
    
    // MARK: Initializers
    
    init(viewModel: SetGameViewModel, safeBottomInset: Double? = nil) {
        self.viewModel = viewModel
        self.safeBottomInset = safeBottomInset
    }
    
    // MARK: Body
    
    var body: some View {
        VStack {
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
            
            Spacer()
                .frame(height: safeBottomInset ?? 0)
        }
        .background(.thinMaterial)
    }
}

// MARK: - Preview

struct GameControlsTab_Previews: PreviewProvider {
    static var previews: some View {
        GameControlsTab(viewModel: SetGameViewModel())
    }
}
