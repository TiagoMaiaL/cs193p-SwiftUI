import SwiftUI

struct PegsView<Peg: PegDisplayable>: View {
    let code: CodeBreakerGame<Peg>.Code
    let isGuessEnabled: Bool
    let onPegTapped: ((Int) -> Void)?
    let onGuessTapped: (() -> Void)?
    
    init(
        code: CodeBreakerGame<Peg>.Code,
        isGuessEnabled: Bool = true,
        onPegTapped: ((Int) -> Void)? = nil,
        onGuessTapped: (() -> Void)? = nil
    ) {
        self.code = code
        self.isGuessEnabled = isGuessEnabled
        self.onPegTapped = onPegTapped
        self.onGuessTapped = onGuessTapped
    }
    
    var body: some View {
        HStack {
            ForEach(code.value.indices, id: \.self) { index in
                code.value[index]
                    .viewForPeg(containedIn: code)
                    .onTapGesture {
                        onPegTapped?(index)
                    }
            }
            
            MatchMarkersView(matches: code.attemptMatches ?? [])
                .padding()
                .opacity(code.isPreviousAttemptCode ? 1 : 0)
                .overlay {
                    if code.isGuessCode {
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
}

// TODO: Provide previews.
