//
//  MemorizeApp.swift
//  Memorize
//
//  Created by Tiago Lopes on 28/06/21.
//

import SwiftUI

@main
struct MemorizeApp: App {
    @StateObject
    private var gameViewModel = EmojiMemorizeViewModel()
    
    var body: some Scene {
        WindowGroup {
            MemorizeView(viewModel: gameViewModel)
        }
    }
}
