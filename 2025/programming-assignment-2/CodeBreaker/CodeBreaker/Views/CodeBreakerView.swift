import SwiftUI
import Playgrounds

struct CodeBreakerView: View {
    //let game = CodeBreakerGame()
    
    var body: some View {
        VStack(spacing: 0) {
            PegsView(colors: [.green, .red, .blue, .yellow])
                .padding(.vertical)
            // TODO: Remove MatchMarkers from master code.
            // TODO: Hide the master code.
            
            PegsView(colors: [.clear, .clear, .clear, .clear])
                .padding(.vertical)
            // TODO: Replace match markers with a guess button
            // TODO: Outline the pegs to be guessed
            
            ScrollView {
                VStack {
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                    PegsView(colors: [.red, .green, .blue, .yellow])
                }
            }
            
            Divider()
            
            Button {
                // TODO: Restart game.
            } label: {
                Text("Restart")
            }
            .padding()
        }
        .padding()
        // TODO: Define Model
        // TODO: Define main views
    }
}

#Preview {
    CodeBreakerView()
}
