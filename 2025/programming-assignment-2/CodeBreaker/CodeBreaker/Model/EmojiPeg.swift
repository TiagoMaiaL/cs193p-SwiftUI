enum EmojiPeg: String, CaseIterable {
    case empty = ""
    case happyFace = "😄"
    case sadFace = "😔"
    case angryFace = "😡"
    case lolFace = "😂"
    case sweatFace = "😰"
    case loveFace = "😍"
}

extension EmojiPeg: GuessableElement {
    static var placeholder: Self { .empty }
    
    var id: String {
        rawValue
    }
    
    func alternate() -> Self {
        let emojiPegs = EmojiPeg.allCases.map(\.rawValue)
        
        guard var targetIndex = emojiPegs.firstIndex(of: self.rawValue) else {
            assertionFailure("self should be in available cases.")
            return .empty
        }
        targetIndex = (targetIndex + 1) % EmojiPeg.allCases.count
        
        return EmojiPeg(rawValue: emojiPegs[targetIndex]) ?? .empty
    }
}
