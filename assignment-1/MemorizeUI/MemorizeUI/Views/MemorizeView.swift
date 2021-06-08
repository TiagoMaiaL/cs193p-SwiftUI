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
            .font(.largeTitle)
            .padding()
    }
    
    var cardsGrid: some View {
        EmptyView()
    }
    
    var footer: some View {
        HStack(alignment: .bottom, spacing: 70) {
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
    }
}

// MARK: - Preview

struct MemorizeView_Previews: PreviewProvider {
    static var previews: some View {
        MemorizeView()
    }
}
