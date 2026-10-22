import SwiftUI

struct PegsView: View {
    let code: CodeBreakerGame<ColorPeg>.Code
    let isGuessEnabled: Bool
    let onPegTapped: ((Int) -> Void)?
    let onGuessTapped: (() -> Void)?
    
    init(
        code: CodeBreakerGame<ColorPeg>.Code,
        isGuessEnabled: Bool = true,
        onPegTapped: ((Int) -> Void)? = nil,
        onGuessTapped: (() -> Void)? = nil
    ) {
        self.code = code
        self.isGuessEnabled = isGuessEnabled
        self.onPegTapped = onPegTapped
        self.onGuessTapped = onGuessTapped
    }
    
    private var attemptMatches: [Match]? {
        switch code {
        case .previousAttempt(_, let matches): return matches
        default: return nil
        }
    }
    
    private var isPreviousAttemptCode: Bool {
        switch code {
        case .previousAttempt: return true
        default: return false
        }
    }
    
    private var isGuessCode: Bool {
        switch code {
        case .guess: return true
        default: return false
        }
    }
    
    private var isMasterCode: Bool {
        switch code {
        case .master: return true
        default: return false
        }
    }
    
    var body: some View {
        HStack {
            ForEach(code.value.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 10)
                    .aspectRatio(1, contentMode: .fit)
                    .foregroundStyle(color(for: index))
                    .overlay {
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: isGuessCode ? 2 : 0)
                    }
                    .contentShape(RoundedRectangle(cornerRadius: 10))
                    .onTapGesture {
                        onPegTapped?(index)
                    }
            }
            
            MatchMarkersView(matches: attemptMatches ?? [])
                .opacity(isPreviousAttemptCode ? 1 : 0)
                .overlay {
                    if isGuessCode {
                        Button {
                            onGuessTapped?()
                        } label: {
                            Text("guess")
                        }
                        .disabled(!isGuessEnabled)
                    }
                }
        }
    }
    
    private func color(for peg: Int) -> Color {
        guard !isMasterCode else {
            return .gray
        }
        return code.value[peg].swiftUIColor
    }
}

extension ColorPeg {
    var swiftUIColor: SwiftUI.Color {
        switch self {
        case .clear: return .clear
        case .blue: return .blue
        case .green: return .green
        case .red: return .red
        case .yellow: return .yellow
        }
    }
}

#Preview {
    VStack {
        PegsView(
            code: CodeBreakerGame<ColorPeg>.Code.master(
                value: [.green, .blue, .blue, .yellow]
            )
        )
        
        PegsView(
            code: CodeBreakerGame<ColorPeg>.Code.guess(
                value: [.red, .green, .blue, .yellow]
            )
        )
        
        PegsView(
            code: CodeBreakerGame<ColorPeg>.Code
                .previousAttempt(
                    value: [.red, .green, .green, .yellow],
                    matches: [.exact, .exact, .inexact, .nomatch]
                )
        )
    }
    .padding()
}
