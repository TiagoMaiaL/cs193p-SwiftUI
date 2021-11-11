//
//  SetCardView.swift
//  Set
//
//  Created by Tiago Lopes on 06/11/21.
//

import SwiftUI

// MARK: - View

struct SetCardView: View {
    
    // MARK: Properties
    
    let viewModel: SetCardViewModel
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            background
            
            VStack {
                Text("Count: \(viewModel.count)")
                Text("Shape: \(viewModel.shape.description)")
                Text("Shading: \(viewModel.shading.description)")
                Text("Color: \(viewModel.color.description)")
                    .foregroundColor(viewModel.color)
            }
        }
    }
    
    private var background: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 5)
                .foregroundColor(cardColor)
            
            RoundedRectangle(cornerRadius: 5)
                .stroke(lineWidth: 2)
        }
    }
    
    private var cardColor: Color {
        if viewModel.isMatched {
            return .yellow
        }
        
        if viewModel.isUnmatched {
            return .red.opacity(0.4)
        }
        
        if viewModel.isSelected {
            return .gray.opacity(0.5)
        }
        
        return .clear
    }
}

// MARK: Preview

struct SetCardView_Previews: PreviewProvider {
    static var previews: some View {
        let card = Card(
            color: .first,
            shape: .first,
            count: .one,
            shading: .second
        )
        let viewModel = SetCardViewModel(card)
        
        return SetCardView(viewModel: viewModel)
            .padding()
    }
}
