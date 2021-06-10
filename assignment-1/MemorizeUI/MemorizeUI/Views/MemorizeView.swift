//
//  MemorizeView.swift
//  MemorizeUI
//
//  Created by Tiago Lopes on 06/06/21.
//

import SwiftUI

struct MemorizeView: View {
    
    // MARK: Body
    
    var body: some View {
        VStack {
            header
            cardsGrid
            Spacer()
            footer
        }
    }
    
    private var header: some View {
        Text(Constants.screenTitle)
            .font(.largeTitle)
            .padding()
    }
    
    private var cardsGrid: some View {
        ScrollView {
            LazyVGrid(columns: Constants.adaptiveColumn) {
                CardView(isFaceUp: true, title: "🍎", color: .red)
                    .aspectRatio(2/3, contentMode: .fill)
                CardView(isFaceUp: true, title: "🪲", color: .green)
                    .aspectRatio(2/3, contentMode: .fill)
                CardView(isFaceUp: true, title: "🦕", color: .blue)
                    .aspectRatio(2/3, contentMode: .fill)
                CardView(isFaceUp: true, title: "🦎", color: .green)
                    .aspectRatio(2/3, contentMode: .fill)
            }
            .padding(.horizontal)
        }
    }
    
    private var footer: some View {
        HStack(alignment: .bottom, spacing: Constants.footerHorizontalSpace) {
            ThemeButton(icon: Constants.VehicleTheme.icon, title: Constants.VehicleTheme.title) {
                debugPrint("Theme 1 tapped")
            }
            
            ThemeButton(icon: Constants.FlagTheme.icon, title: Constants.FlagTheme.title) {
                debugPrint("Theme 2 tapped")
            }
            
            ThemeButton(icon: Constants.NatureTheme.icon, title: Constants.NatureTheme.title) {
                debugPrint("Theme 3 tapped")
            }
        }
    }
}

// MARK: - Constants

private extension MemorizeView {
    enum Constants {
        enum VehicleTheme {
            static let icon = "car"
            static let title = "Vehicles"
        }
        
        enum FlagTheme {
            static let icon = "flag"
            static let title = "Flags"
        }
        
        enum NatureTheme {
            static let icon = "leaf"
            static let title = "Nature"
        }
        
        static let screenTitle = "Memorize!"
        static let footerHorizontalSpace: CGFloat = 70
        static let adaptiveColumn = [GridItem(.adaptive(minimum: 85))]
    }
}

// MARK: - Preview

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
