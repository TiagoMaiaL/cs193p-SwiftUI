enum ColorPeg: Int, CaseIterable {
    case clear
    case red
    case green
    case blue
    case yellow
    case purple
    case pink
    
    private static var releventCases: [Self] = {
        var relevantCases = ColorPeg.allCases
        relevantCases.removeFirst()
        return relevantCases
    }()
    
    static var randomElement: Self {
        guard let random = releventCases.randomElement() else {
            assertionFailure("Random element should be returned.")
            return .red
        }
        
        return random
    }
    
    static var randomOptions: [Self] {
        var options: [ColorPeg] = []
        var randomCount = Int.random(in: 4...6)
        
        while randomCount > 0 {
            options.append(randomElement)
            randomCount -= 1
        }
        
        return options
    }
}

extension ColorPeg: GuessableElement {
    static var placeholder: Self { .clear }
    
    var id: Int {
        rawValue
    }
    
    func alternate() -> Self {
        ColorPeg(rawValue: (rawValue + 1) % ColorPeg.allCases.count) ?? Self.placeholder
    }
}
