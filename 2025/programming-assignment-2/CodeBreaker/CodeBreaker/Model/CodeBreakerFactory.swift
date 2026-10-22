import Foundation

enum ColorPeg: Int, CaseIterable {
    case clear
    case red
    case green
    case blue
    case yellow
}

extension ColorPeg: GuessableElement {
    static var placeholder: ColorPeg { .clear }
    
    var id: Int {
        rawValue
    }
    
    func alternate() -> ColorPeg {
        ColorPeg(rawValue: (rawValue + 1) % ColorPeg.allCases.count) ?? Self.placeholder
    }
}

enum CodeBreakerFactory {
    static func make() -> CodeBreakerGame<ColorPeg> {
        return CodeBreakerGame<ColorPeg>(codeElements: [.red, .green, .blue, .blue])
    }
}
