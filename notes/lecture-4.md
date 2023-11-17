
 # Lecture 4 - Notes

 # Demo - MemoryGame continued

 - In MVVM, views have a reference to the view model, they need to talk to it:
 ```swift
 struct ContentView: View {
     var viewModel: EmojiMemoryGame
 }
 ```

 - The view model has a reference to the model:
 ```swift
 class EmojiMemoryGame {
     var model: MemoryGame<String>
 }
 ```

 - The view model publishes changes, and doesn't have references to the view (reactive and stateless)

 - Forbid direct access to the model with access control:
 ```swift
 class EmojiMemoryGame {
     private var model: MemoryGame<String>

     // Provide methods or variables that return data from the model, prepared for any views
     var cards: Array<MemoryGame<String>.Card> { 
         model.cards
     }

     // Intent function (ends up mutating the model, in this case)
     func choose(_ card: MemoryGame<String>.Card) {
         model.choose(card)
     }
 }
 ```

 - The model can also protect direct mutation of its data:
 ```swift
 struct MemoryGame<CardContent> {
     private(set) var card: Array<Card>
 }
 ```

 - Start out with `private` access control, then change it according to your needs

 - The model in this case knows how to initialize itself (custom `init`):
 ```swift
 struct MemoryGame<CardContent> {
     init(numberOfPairsOfCards: Int, cardContentFactory: (Int) -> CardContent) {
         cards = []
         for pairIndex in 0 ..< numberOfPairsOfCards {
             let cardContent = cardContentFactory(pairIndex)
             cards.append(Card(content: cardContent))
             cards.append(Card(content: cardContent))
         }
     }
 }
 ```

 - Closures have knowledge on how to accomplish a specific task
   - In the above case, it knows how to create content for the memory game
   - This knowledge can be passed around

 - Closure usage in the view model:
 ```swift
 private static let emojis = ["..."]
 private var model = MemoryGame<String>(
     numberOfPairsOfCards: 4,
     cardContentFactory: { pairIndex in
         return emojis[pairIndex] // Swift will find the global emojis property
     }
 )
 ```

 - `static var`s or `func`s:
   - Belong to the type itself (which also acts as a namespace for them)
   - Well used with initalization code
   - Lots of uses in SwiftUI:
     - `Font.largeTitle`
     - `Color.red`

 - `CardView` now receives a `card`:
 ```swift
 struct CardView: View {
     let card: MemoryGame<String>.card

     // Since this view is pretty simple, it can grab the data directly from the model:
     ZStack {
         let base = RoundedRectangle(cornerRadius: 12)
         Group {
             base.fill(.white)
             base.strokeBorder(lineWidth: 2)
             // Here we grab the card emoji
             Text(card.content).font(.largeTitle)
         }
         .opacity(card.isFaceUp ? 1 : 0) // Here we check if it's face up (we show its content)

         // Or, if it is face down:
         base.fill()
             .opacity(card.isFeceUp ? 0 : 1)
     }
 }
 ```

 - `EmojiMemoryGameView` now uses the data from its view model:
 ```swift
 // ...
 ForEach(viewModel.cards.indices, id: \.self) { index in
     CardView(card: viewModel.cards[index])
         .aspectRation(2/3, contentMode: .fit)
 }
 // ...
 ```

 - As an exercise, experiment the font fitting trick with different sizes:
 ```swift
 Text(card.content)
     .font(.system(size: 200))
     .minimumScaleFactor(0.01)
     .aspectRatio(1, contentMode: .fit)
 ``` 

 - `mutating` methods in `struct`s:
 ```swift
 mutating func shuffle() {
     cards.shuffle()
 }
 ```

 - Reactive UI:
   - `ObservableObject` and `@ObservedObject`:
     ```swift
     class EmojiMemoryGame: ObservableObject {
         // This will trigger an update event when the model changes
         @Published private var model = createMemoryGame()
     }
 
     // The call-site (view code) will then observe this view model:
     struct EmojiMemoryGameView: View {
         // SwiftUI starts observing changes from the view model and redraws the views accordingly:
         @ObservedObject var viewModel: EmojiMemoryGame
         // Notice that @ObservedObject means that the view observes it but doesn't manage it 
         // According to the view lifecycle.
     }
     ```
   - `@StateObject`:
     - Manages the instance tying it to a view lifecycle. We constantly use this within the `App` struct:
     ```swift
     @main
     struct MemorizeApp: App {
         @StateObject var game = EmojiMemoryGame()

         var body: some Scene {
             WindowGroup {
                 EmojiMemoryGameView(viewModel: game)
             }
         }
     }
     ```


 
