 # Lecture 9 - Notes

 ## Animation Part II - Demo

 - `FlyingNumber` continued:
   - Logic for computing `lastScoreChange`, using a tuple
   - The logic for it is contained in the `EmojiMemoryGameView`, it could be contained in the view model, though
   - In the card view:
   ```swift
   CardView(card)
       .padding(spacing)
       .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
       .zIndex(scoreChange(causedBy: card) != 0 ? 100 : 0)
       .onTapGesture {
           // TODO: Set and compute the score change
       }
   ```
   - The `View` code:
   ```swift
   struct FlyingNumber: View {
       let number: Int
       @State private var offset: CGFloat = 0
       
       var body: some View {
           if number != 0 {
               Text(number, format: .number.sign(strategy: .always()))
                   .font(.largeTitle)
                   .foregroundColor(number < 0 ? .red : .green)
                   .shadow(color: .black, radius: 1.5, x: 1, y: 1)
                   .offset(x: 0, y: offset)
                   .opacity(offset != 0 ? 0 : 1)
                   .onAppear(.easeIn(duration: 1.5)) {
                       withAnimation {
                           offset = number < 0 ? 200 : -200
                       }
                   }
                   .onDisappear {
                       offset = 0
                   }
           }
       }
   }
   ```
