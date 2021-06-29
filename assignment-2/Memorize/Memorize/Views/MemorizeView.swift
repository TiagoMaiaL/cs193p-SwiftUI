//
//  MemorizeView.swift
//  Memorize
//
//  Created by Tiago Lopes on 28/06/21.
//

import SwiftUI

// MARK: - View

struct MemorizeView: View {
    var body: some View {
        VStack {
            Text("Memorize!")
                .font(.largeTitle)
                .padding()
            
            Spacer()
            
            CardsGridView()
        }
    }
}

// MARK: - Preview

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
