//
//  OvalView.swift
//  Set
//
//  Created by Tiago Lopes on 15/11/21.
//

import SwiftUI

struct OvalView: View {
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: geometry.size.width / 2)
        }
    }
}

struct OvalView_Previews: PreviewProvider {
    static var previews: some View {
        OvalView()
            .padding()
    }
}
