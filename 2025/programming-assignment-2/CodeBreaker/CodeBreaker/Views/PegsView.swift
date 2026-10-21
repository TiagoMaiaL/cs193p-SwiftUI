import SwiftUI

struct PegsView: View {
    let colors: [Color]
    
    var body: some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarkersView(matches: [.exact, .inexact, .exact, .nomatch])
        }
    }
}

#Preview {
    PegsView(colors: [.red, .green, .blue, .yellow])
        .padding()
}
