//
//  SetGameApp.swift
//  Set
//
//  Created by Tiago Lopes on 23/09/21.
//

import SwiftUI

@main
struct SetGameApp: App {
    
    // MARK: Properties
    
    @StateObject
    var viewModel = SetGameViewModel()
    
    // MARK: Body
    
    var body: some Scene {
        WindowGroup {
            SetGameView(viewModel: viewModel)
        }
    }
}
