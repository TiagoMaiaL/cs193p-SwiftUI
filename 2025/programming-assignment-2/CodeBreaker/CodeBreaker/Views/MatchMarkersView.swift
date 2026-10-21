import SwiftUI

struct MatchMarkersView: View {
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
    private func marker(peg: Int) -> some View {
        let exactCount = matches.count { $0 == .exact }
        let foundCount = matches.count { $0 != .nomatch }

        Circle()
            .fill(exactCount > peg ? Color.primary : Color.clear)
            .stroke(foundCount > peg ? Color.primary : Color.clear, lineWidth: 2)
    }
}

#Preview {
    VStack(spacing: 10) {
        MatchMarkersView(matches: [.exact, .inexact, .exact, .nomatch])
        MatchMarkersView(matches: [.inexact, .inexact, .exact, .nomatch, .nomatch, .inexact])
    }
        .padding()
}
