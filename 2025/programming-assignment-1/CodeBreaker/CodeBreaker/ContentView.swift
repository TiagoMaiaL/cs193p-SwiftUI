import SwiftUI
import Playgrounds

struct ContentView: View {
    var body: some View {
        VStack {
            pegs(colors: [.blue, .yellow, .green, .blue])
            pegs(colors: [.red, .red, .green, .yellow])
            pegs(colors: [.green, .blue, .blue, .red])
        }
        .padding()
    }
    
    func pegs(colors: [Color]) -> some View {
        HStack {
            ForEach(colors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(colors[index])
            }
            MatchMarker(matches: [.exact, .exact, .nomatch, .inexact])
        }
    }
}

#Preview {
    ContentView()
}
