//
//  CardView.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import SwiftUI

// MARK: - View

struct CardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: Constants.rectangleRadius)
                .stroke(lineWidth: Constants.borderWidth)
                .foregroundColor(.green)
            
            Text("🇧🇷")
                .font(.system(size: Constants.textFontSize))
        }
    }
}

// MARK: Constants

private extension CardView {
    enum Constants {
        static let rectangleRadius = 10.0
        static let borderWidth = 2.0
        static let textFontSize = 40.0
    }
}

// MARK: - Preview

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView()
    }
}
