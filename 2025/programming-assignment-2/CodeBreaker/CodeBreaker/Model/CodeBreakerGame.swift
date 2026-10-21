import Foundation

struct CodeBreakerGame<CodeElement: GuessableElement> {
    private(set) var state: State
    let masterCode: Code
    let previousAttempts: [Code] = []
    private(set) var currentGuess: Code?
    
    init(codeElements: [CodeElement]) {
        state = .playing
        self.masterCode = Code.master(value: codeElements)
    }
    
    mutating func setPegAtIndex(_ index: Int) {
        guard index < masterCode.lenght else {
            assertionFailure("Peg out of bounds")
            return
        }
        
        let guess = currentGuess ?? Code.guess(
            value: Array<CodeElement>(repeating: CodeElement.placeholder, count: masterCode.lenght)
        )
        var value = guess.value
        value[index] = value[index].alternate()
        
        currentGuess = Code.guess(value: value)
    }
    
    mutating func guess() {
        guard let guess = currentGuess else { return }
        guard guess.lenght == masterCode.lenght else {
            assertionFailure("Inconsistent code length: guess != masterCode")
        }
        // TODO: Prevent already guessed values.
        
        switch state {
        case .playing:
            if guess.value == masterCode.value {
                state = .finished(userDidWin: true)
                return
            }
            
            var matches: [Match] = .init(repeating: .nomatch, count: masterCode.lenght)
            
            for (i, element) in guess.value.enumerated() {
                if masterCode.value[i] == element {
                    matches[i] = .exact
                } else if masterCode.value.contains(element) {
                    matches[i] = .inexact
                } else {
                    matches[i] = .nomatch
                }
            }
            
        case .finished:
            break
        }
    }
}

extension CodeBreakerGame {
    enum State {
        case playing
        case finished(userDidWin: Bool)
    }
}

// MARK: - Code

extension CodeBreakerGame {
    enum Code {
        case master(value: [CodeElement])
        case guess(value: [CodeElement])
        case previousAttempt(value: [CodeElement], matches: [Match])
        
        var lenght: Int {
            switch self {
            case .master(let value): return value.count
            case .guess(let value): return value.count
            case .previousAttempt(let value, _): return value.count
            }
        }
        
        var value: [CodeElement] {
            switch self {
            case .master(let value): return value
            case .guess(let value): return value
            case .previousAttempt(let value, _): return value
            }
        }
    }
}

protocol GuessableElement: Equatable, Identifiable {
    static var placeholder: Self { get }
    func alternate() -> Self
}

// MARK: - Match

enum Match {
    case exact
    case inexact
    case nomatch
}
