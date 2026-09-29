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
 - Coundown timer
   - bonus computation is part of the model
   - `Pie` now takes `card.bonusPercentRemaining`:
   ```swift
   Pie(endAngle: .degrees(card.bonusPercentRemaining * 360))
   ```
   - We can use a `TimelineView` to animate our `Pie`:
   ```swift
   TimelineView(.animation) { timeline in
       Pie(endAngle: ...)
          ...
   }
   ```
   - `TimelineView` receives a view and tries to redraw it at the specified intervals
   - One can use `.animation`, which makes the received view animate
 - Dealing cards
   - Use transitions to make the cards go alway with a different animation, the default one is `.animation(.opacity)`
   - Whenever the cards grid appear, deal the cards
   - The notion of dealing cards is part of the View, the model doesn't have any ideas on how to do that
   ```swift
   AspectVGrid(...) {
       if isDealt(card) {
           CardView(card)
               ...
               .transition(.offset(
                   x: CGFloat.random(in: -1000...1000),
                   y: CGFloat.random(in: -1000...1000)
               ))
       }
       // ...
   }
   .onAppear {
       withAnimation {
           for card in viewModel.cards {
               dealt.insert(card.id)
           }
       }
   }

   // ...

   // Since dealing is part of the UI, we can keep this state in the view itself.
   @State private var dealt = Set<Card.ID>()

   private func isDealt(_ card: Card) -> Bool {
       dealt.contains(card.id)
   }

   private var undealtCards: [Card] {
       viewModel.cards.filter { !isDealt($0) }
   }
   ```
   - These cards need to be dealt from a deck:
   ```swift
   ZStack {
      ForEach(undealtCards) { card in
         CardView(card) 
      }
      .frame(width: deckWidth, height: deckWidth / aspectRatio) // This view modifier allows us to choose the size of a view
                                                                // Be careful to use this, as it can be abused, it's better to use
                                                                // The size offered, or compute the view's size based on it
      .onTapGesture {
          // deal with animation
      }
   }
   ```
   - This is a good time to use `MatchedGeometryEffect`:
   ```swift
   @Namespace private var dealingNamespace

   .matchedGeometryEffect(id: card.id, in: dealingNamespace) // We use different namespaces when the transtion might happen to multiple views
   ```
   - **The views will match the geometry effect, but the transitions will still be there**
   - Workaround: use asymmetric .identity transtions to erase any kind of transitions while still applying matched geometry effect
   ```swift
   .transition(.asymmetric(insertion: .identity, removal: .identity)
   ```
   - Deal one card at a time:
   ```swift
   .onTapGesture {
       var delay: TimeInterval = 1
       for card in viewMidel.cards {
           withAnimation(.easeInOut(duration: 1).delay(delay)) {
               dealt.insert(card.id)
           }
       }
       delay += 0.15
   }
   ```

