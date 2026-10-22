import Foundation
import Observation

@Observable
final class CodeBreakerGame<CodeElement: GuessableElement> {
    private(set) var state: State
    private(set) var masterCode: Code
    private(set) var previousAttempts: [Code] = []
    private(set) var currentGuess: Code
    var canGuess: Bool {
        return !currentGuess.value.contains(where: { $0 == CodeElement.placeholder }) &&
            !previousAttempts.map(\.value).contains(currentGuess.value)
    }
    private var emptyGuess: Code {
        .guess(
            value: Array(repeating: CodeElement.placeholder, count: masterCode.lenght)
        )
    }
    
    init(codeElements: [CodeElement]) {
        state = .playing
        masterCode = .master(value: codeElements, shouldReveal: false)
        currentGuess = Code.guess(
            value: Array(repeating: CodeElement.placeholder, count: codeElements.count)
        )
    }
    
    func setPegAtIndex(_ index: Int) {
        guard index < masterCode.lenght else {
            assertionFailure("Peg out of bounds")
            return
        }
        
        let guess = currentGuess
        var value = guess.value
        value[index] = value[index].alternate()
        
        currentGuess = Code.guess(value: value)
    }
    
    func guess() {
        guard currentGuess.lenght == masterCode.lenght else {
            assertionFailure("Inconsistent code length: guess != masterCode")
        }
        guard canGuess else { return }
        guard !previousAttempts.map(\.value).contains(currentGuess.value) else { return }
        
        switch state {
        case .playing:
            if currentGuess.value == masterCode.value {
                state = .finished(userDidWin: true)
                masterCode = .master(value: masterCode.value, shouldReveal: true)
                currentGuess = emptyGuess
                return
            }
            
            var matches: [Match] = .init(repeating: .nomatch, count: masterCode.lenght)
            
            for (i, element) in currentGuess.value.enumerated() {
                if masterCode.value[i] == element {
                    matches[i] = .exact
                } else if masterCode.value.contains(element) {
                    matches[i] = .inexact
                } else {
                    matches[i] = .nomatch
                }
            }
            
            previousAttempts.append(.previousAttempt(value: currentGuess.value, matches: matches))
            currentGuess = emptyGuess
            
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
    enum Code: Equatable {
        case master(value: [CodeElement], shouldReveal: Bool)
        case guess(value: [CodeElement])
        case previousAttempt(value: [CodeElement], matches: [Match])
        
        var lenght: Int {
            switch self {
            case .master(let value, _): return value.count
            case .guess(let value): return value.count
            case .previousAttempt(let value, _): return value.count
            }
        }
        
        var value: [CodeElement] {
            switch self {
            case .master(let value, _): return value
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
