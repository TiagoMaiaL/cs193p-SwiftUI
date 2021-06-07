//
//  MemorizeView.swift
//  MemorizeUI
//
//  Created by Tiago Lopes on 06/06/21.
//

import SwiftUI

struct MemorizeView: View {
    var body: some View {
        VStack {
            header
            Spacer()
            cardsGrid
            Spacer()
            footer
        }
    }
    
    var header: some View {
        Text("Memorize!")
            .font(.headline)
            .padding()
    }
    
    var cardsGrid: some View {
        EmptyView()
    }
    
    var footer: some View {
        HStack {
            Button("Theme1") {
                debugPrint("Theme 1 tapped")
            }
            
            Button("Theme2") {
                debugPrint("Theme 2 tapped")
            }
            
            Button("Theme3") {
                debugPrint("Theme 3 tapped")
            }
        }
    }
}

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
