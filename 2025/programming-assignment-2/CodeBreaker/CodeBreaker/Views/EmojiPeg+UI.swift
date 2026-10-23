import SwiftUI

extension EmojiPeg: PegDisplayable {
    func viewForPeg(containedIn code: CodeBreakerGame<EmojiPeg>.Code) -> some View {
        RoundedRectangle(cornerRadius: 10)
            .stroke(lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
            .overlay {
                Text(string(using: code))
                    .font(.largeTitle)
            }
            .contentShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func string(using code: CodeBreakerGame<EmojiPeg>.Code) -> RawValue {
        if code.isMasterCode, !code.shouldRevealMasterCode {
            return "❓"
        }
        
        return rawValue
    }
}
