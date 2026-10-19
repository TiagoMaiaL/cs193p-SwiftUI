import SwiftUI

enum Match {
    case nomatch
    case exact
    case inexact
}

struct MatchMarker: View {
    let matches: [Match]
    
    var body: some View {
        HStack {
            VStack {
                marker(peg: 0)
                marker(peg: 1)
            }
            VStack {
                marker(peg: 2)
                marker(peg: 3)
            }
            if matches.count > 4 {
                VStack {
                    marker(peg: 4)
                    marker(peg: 5)
                }
            }
        }
    }
    
    @ViewBuilder
    func marker(peg: Int) -> some View {
        let exactCount: Int = matches.count { $0 == .exact }
        let foundCount: Int = matches.count { $0 != .nomatch }
        Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .strokeBorder(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
            .aspectRatio(1, contentMode: .fit)
    }
}

#Preview {
    struct Preview: View {
        let matches: [Match]
        var body: some View {
            HStack {
                ForEach(matches.indices, id: \.self) { _ in
                    Circle()
                }
                MatchMarker(matches: matches)
            }
        }
    }
    
    return VStack {
        Preview(matches: [.exact, .inexact, .nomatch])
        Preview(matches: [.exact, .nomatch, .nomatch, .inexact])
        Preview(matches: [.nomatch, .nomatch, .nomatch, .inexact])
        Preview(matches: [.nomatch, .nomatch, .exact, .exact])
        Preview(matches: [.nomatch, .nomatch, .exact, .exact, .inexact])
        Preview(matches: [.exact, .inexact, .exact, .exact, .inexact])
        Preview(matches: [.exact, .inexact, .exact, .exact, .inexact, .exact])
    }
    .padding()
}
