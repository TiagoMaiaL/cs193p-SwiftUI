//
//  MemorizeView.swift
//  MemorizeUI
//
//  Created by Tiago Lopes on 06/06/21.
//

import SwiftUI

struct MemorizeView: View {
    
    // MARK: Properties
    
    let vehicleEmojis = ["🚔", "🚗", "🚒", "🚚", "🚌", "🛻"]
    let flagEmojis = ["🇧🇷", "🇪🇸", "🇵🇹", "🇩🇪", "🇺🇸"]
    let natureEmojis = ["🌳", "🌲", "🌵", "🌷", "🌴", "🌻", "🌺"]
    
    @State private var currentEmojis = [String]()
    @State private var themeColor = Color.red
    
    // MARK: Body
    
    var body: some View {
        VStack {
            header
            cardsGrid
            Spacer()
            footer
        }
        .onAppear {
            apply(theme: vehicleEmojis)
        }
    }
    
    private var header: some View {
        Text(Constants.screenTitle)
            .font(.largeTitle)
            .padding()
    }
    
    private var cardsGrid: some View {
        ScrollView {
            LazyVGrid(columns: Constants.adaptiveColumn, spacing: Constants.gridItemSpacing) {
                ForEach(currentEmojis.indices, id: \.self) { index in
                    CardView(isFaceUp: false, title: currentEmojis[index], color: themeColor)
                        .aspectRatio(Constants.twoThirds, contentMode: .fill)
                }
            }
            .padding(.horizontal)
        }
    }
    
    private var footer: some View {
        HStack(alignment: .bottom, spacing: Constants.footerHorizontalSpace) {
            ThemeButton(icon: Constants.VehicleTheme.icon, title: Constants.VehicleTheme.title) {
                themeColor = .red
                apply(theme: vehicleEmojis)
            }
            
            ThemeButton(icon: Constants.FlagTheme.icon, title: Constants.FlagTheme.title) {
                themeColor = .blue
                apply(theme: flagEmojis)
            }
            
            ThemeButton(icon: Constants.NatureTheme.icon, title: Constants.NatureTheme.title) {
                themeColor = .green
                apply(theme: natureEmojis)
            }
        }
    }
    
    // MARK: Imperatives
    
    private func apply(theme: [String]) {
        currentEmojis = generatePairedEmojis(for: theme).shuffled()
    }
    
    private func generatePairedEmojis(for theme: [String]) -> [String] {
        theme + theme
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
        static let footerHorizontalSpace = 70.0
        static let gridItemSpacing = 5.0
        static let adaptiveColumn = [GridItem(.adaptive(minimum: 85), spacing: gridItemSpacing)]
        static let twoThirds = 2.0/3.0
    }
}

// MARK: - Preview

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
