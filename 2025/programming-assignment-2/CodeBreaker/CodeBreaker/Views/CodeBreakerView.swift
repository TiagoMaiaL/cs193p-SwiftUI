import SwiftUI

protocol PegDisplayable: GuessableElement {
    associatedtype PegView: View
    func viewForPeg(containedIn code: CodeBreakerGame<Self>.Code) -> PegView
}

struct CodeBreakerView<Peg: PegDisplayable>: View {
    var game: CodeBreakerGame<Peg>
    
    let onRestartTapped: (() -> Void)?
    
    init(game: CodeBreakerGame<Peg>, onRestartTapped: (() -> Void)? = nil) {
        self.game = game
        self.onRestartTapped = onRestartTapped
    }
    
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
                onRestartTapped?()
            } label: {
                Text("Restart")
            }
            .padding()
        }
        .padding()
    }
}

#Preview {
    //CodeBreakerView(game: CodeBreakerFactory.make())
}
