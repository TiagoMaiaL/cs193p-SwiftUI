//
//  MemorizeView.swift
//  MemorizeUI
//
//  Created by Tiago Lopes on 06/06/21.
//

import SwiftUI

struct MemorizeView: View {
    
    // MARK: Properties
    
    let vehicleEmojis = ["🚔", "🚗", "🚒", "🚚", "🚌", "🛻", "🚛", "🚑", "🚜"]
    let flagEmojis = ["🇧🇷", "🇪🇸", "🏴󠁧󠁢󠁥󠁮󠁧󠁿", "🇺🇸", "🇿🇦", "🇲🇽", "🇯🇵", "🇵🇹", "🇩🇪", "🇵🇱", "🇦🇹", "🇮🇹", "🇫🇷", "🇦🇷", "🇨🇱"]
    let natureEmojis = ["🌳", "🌲", "🌵", "🌷", "🌴", "🌻", "🌺", "⛰", "🗻", "🍄"]
    
    @State private var currentEmojis: [String]
    @State private var themeColor = Color.red
    
    // MARK: Initializers
    
    init() {
        currentEmojis = vehicleEmojis
    }
    
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
                ForEach(currentEmojis, id: \.self) { emoji in
                    CardView(isFaceUp: true, title: emoji, color: themeColor)
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
                currentEmojis = vehicleEmojis.shuffled()
            }
            
            ThemeButton(icon: Constants.FlagTheme.icon, title: Constants.FlagTheme.title) {
                themeColor = .blue
                currentEmojis = flagEmojis.shuffled()
            }
            
            ThemeButton(icon: Constants.NatureTheme.icon, title: Constants.NatureTheme.title) {
                themeColor = .green
                currentEmojis = natureEmojis.shuffled()
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
        static let twoThirds: CGFloat = 2/3
    }
}

// MARK: - Preview

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
