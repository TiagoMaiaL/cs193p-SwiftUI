import SwiftUI

struct CodeBreakerView: View {
    @State
    var game: CodeBreakerGame<ColorPeg>
    
    var body: some View {
        VStack(spacing: 0) {
            PegsView(code: game.masterCode)
                .padding(.vertical)
            
            PegsView(
                code: game.currentGuess,
                isGuessEnabled: game.canGuess,
                onPegTapped: { index in
                    game.setPegAtIndex(index)
                },
                onGuessTapped: {
                    game.guess()
                }
            )
            .padding(.vertical)
            
            ScrollView {
                VStack {
                    ForEach(game.previousAttempts.indices, id: \.self) { codeIndex in
                        PegsView(code: game.previousAttempts[codeIndex])
                    }
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
    }
}

#Preview {
    CodeBreakerView(game: CodeBreakerFactory.make())
}
