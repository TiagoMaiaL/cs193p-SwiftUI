//
//  ThemeButton.swift
//  MemorizeUI
//
//  Created by Tiago Lopes on 08/06/21.
//

import SwiftUI

struct ThemeButton: View {
    
    // MARK: Properties
    
    let icon: String
    let title: String
    let action: () -> Void
    
    // MARK: Body
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 5) {
                Image(systemName: icon)
                    .font(.title)
                Text(title)
                    .font(.caption)
            }
        }
    }
}

// MARK: - Preview

struct ThemeButton_Previews: PreviewProvider {
    static let icon = "car"
    static let title = "Vehicles"
    static let action: () -> Void = {}
    
    static var previews: some View {
        ThemeButton(icon: icon, title: title, action: action)
    }
}
