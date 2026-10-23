enum CodeBreakerFactory {
    static func makeEmojiGame() -> CodeBreakerGame<EmojiPeg> {//ColorPeg> {
        // TODO: Make game choose between random types of pegs
        //return CodeBreakerGame<ColorPeg>(codeElements: ColorPeg.randomOptions)
        return CodeBreakerGame<EmojiPeg>(
            codeElements: [.angryFace, .happyFace, .lolFace, .loveFace]
        )
    }
    
    static func makeColorGame() -> CodeBreakerGame<ColorPeg> {
        return CodeBreakerGame<ColorPeg>(codeElements: ColorPeg.randomOptions)
    }
}
