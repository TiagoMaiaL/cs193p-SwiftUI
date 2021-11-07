//
//  SetGameView.swift
//  Set
//
//  Created by Tiago Lopes on 08/10/21.
//

import SwiftUI

// MARK: - View

struct SetGameView: View {
    
    // MARK: Properties
    
    @StateObject
    var game = SetGameViewModel()
    
    // MARK: Body
    
    var body: some View {
        EmptyView()
    }
}

// MARK: - Preview

struct SetGameView_Previews: PreviewProvider {
    static var previews: some View {
        SetGameView()
    }
}
