//
//  CardView.swift
//  Memorize
//
//  Created by Tiago Lopes on 29/06/21.
//

import SwiftUI

// MARK: - View

struct CardView: View {
    
    // MARK: Properties
    
    @State var isFaceUp = true
    
    // MARK: Body
    
    var body: some View {
        ZStack {
            Group {
                if isFaceUp {
                    rectangle
                        .stroke(lineWidth: Constants.borderWidth)
                    Text("🇧🇷")
                        .font(.system(size: Constants.textFontSize))
                } else {
                    rectangle
                }
            }
            .foregroundColor(.green)
            .contentShape(rectangle)
            .onTapGesture {
                isFaceUp.toggle()
            }
        }
    }
    
    private var rectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: Constants.rectangleRadius)
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
