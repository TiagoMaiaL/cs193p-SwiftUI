//
//  CardView.swift
//  MemorizeUI
//
//  Created by Tiago Lopes on 08/06/21.
//

import SwiftUI

struct CardView: View {
    
    // MARK: Properties
    
    @State var isFaceUp = true
    let title: String
    let color: Color
    
    // MARK: Body
    
    var body: some View {
        Group {
            if isFaceUp {
                frontView
            } else {
                backView
            }
        }
        .contentShape(rectangle)
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
    
    private var rectangle: RoundedRectangle {
        RoundedRectangle(cornerRadius: 10)
    }
    
    private var frontView: some View {
        ZStack {
            rectangle
                .strokeBorder(lineWidth: 3)
                .foregroundColor(color)
            
            Text(title)
                .font(.largeTitle)
        }
    }
    
    private var backView: some View {
        rectangle
            .foregroundColor(color)
    }
}

// MARK: - Preview

struct CardView_Previews: PreviewProvider {
    static var previews: some View {
        CardView(title: "🍎", color: .red)
    }
}
