import SwiftUI

struct CodeBreakerView: View {
    @State
    var game: CodeBreakerGame<ColorPeg>
    
    var body: some View {
        VStack {
            PegsView(code: game.masterCode)
            
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
            .padding(.bottom)
            
            Divider()
            
            ScrollView {
                VStack {
                    ForEach(game.previousAttempts.indices, id: \.self) { codeIndex in
                        PegsView(code: game.previousAttempts[codeIndex])
                    }
                }
                .padding(.vertical)
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
