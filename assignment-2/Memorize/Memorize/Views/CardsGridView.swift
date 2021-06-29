//
//  CardsGridView.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import SwiftUI

// MARK: - View

struct CardsGridView: View {
    var body: some View {
        LazyVGrid(columns: Constants.adaptiveColumn) {
            ForEach(0..<12) { _ in
                CardView()
                    .aspectRatio(Constants.cardAspectRatio, contentMode: .fit)
            }
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
        CardsGridView()
    }
}
