import SwiftUI

extension ColorPeg: PegDisplayable {
    func viewForPeg(containedIn code: CodeBreakerGame<Self>.Code) -> some View {
        RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(color(using: code))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: code.isGuessCode ? 2 : 0)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 10))
    }
    
    private func color(using code: CodeBreakerGame<Self>.Code) -> Color {
        if code.isMasterCode, !code.shouldRevealMasterCode {
            return .gray
        }
        return swiftUIColor
    }
    
    private var swiftUIColor: Color {
        switch self {
        case .clear: return .clear
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .yellow: return .yellow
        case .purple: return .purple
        case .pink: return .pink
        }
    }
}
