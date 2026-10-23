import SwiftUI

@main
struct CodeBreakerApp: App {
    // Simple solutions for which game to choose:
    // 1. Hold a game for each peg type and then decide which one to use (simplest)
    // 2. Try to return the PegType using some and then build a game with it (research on this)
    
    @State
    var emojiGame: CodeBreakerGame<EmojiPeg> = CodeBreakerFactory.makeEmojiGame()
    
    @State
    var colorGame: CodeBreakerGame<ColorPeg> = CodeBreakerFactory.makeColorGame()
    
    @State
    var gameChoice: Bool = Bool.random()
    
    var body: some Scene {
        WindowGroup {
            if gameChoice {
                CodeBreakerView(game: emojiGame, onRestartTapped: {
                    gameChoice = Bool.random()
                })
            } else {
                CodeBreakerView(game: colorGame, onRestartTapped: {
                    gameChoice = Bool.random()
                })
            }
        }
    }
}
