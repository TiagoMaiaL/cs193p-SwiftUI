
 # Lecture 5 - Notes

 - `@StateObject` vs. `@ObservedObject`:
   - **Lifetime** vs **scope**
     - `@State` or `@StateObject` are tied to the **lifetime** of their associated view
       - The values are kept while the view exists. Once it's gone, the values are deallocated
       - That's the reason we can declare an `@StateObject` in the App, as it'll be **tied** to the lifecycle of the application
       - We want the view model to continue existing even though some views are gone
       - **scope**:
         - The view declaring it has access to that state property
         - The other views declared in its `body` also have access to it
         - Won't be used by sibling views
     - `@ObservedObject`
       - The view simply observes it, but it's lifecycle isn't tied to the view at all
       - It must be passed to the view, so the responsability of keeping it around must be ensured by whoever is passing it

 - Animations
   - Are important in a mobile app
   - For now, it's being shown as a way to introduce `protocol`s
   ```swift
     cards
       .animation(.default, value: viewModel.cards) // Whenever viewModel.cards changes, the animation happens
                            // value must conform to the `Equatable` **protocol** (it needs to compare different values of it)
   ```

 - `Equatable` conformance
 ```swift
 struct card: Equatable {
   static func == (lhs: Card, rhs: Card) -> Bool {
     return lhs.isFaceUp == rhs.isFaceUp &&
            lhs.isMatched == rhs.isMatched &&
            lhs.content == rhs.content // CardContent must be Equatable as well, so we need to constrain it:
   }
 }
 ```
 
 - Type constraints:
   - We can require a generic type to behave like something
   - In the below example, we want to be able to check for equality:
   ```swift
   struct MemoryGame<CardContent> where CardContent: Equatable { ... }
   ```

 - Now that `CardContent` is `Equatable`, swift can synthesize the Equatable implementation for this struct:
 ```swift
 struct Card: Equatable { ... }
 ```

 - The animations are fading (we want them to move). The reason is that `ForEach` isn't implemented properly:
   - Its **Identitiy** is tied to the indexes of the cards, which is wrong
   - To **tie** the views inside `ForEach` to the identity of our cards, we need to iterate over the cards themselves:
     ```swift
       ForEach(viewModel.cards, id: \.self) { card in ... }
                                // The identifier is the card itself. In other words, use the card itself as the identity for the views
     ```
   - The `id` parameter must be uniquely identifiable (`Hashable`), but we don't want to hash some properties of our cards (e.g `isFaceUp`)
     - We don't want to isFaceUp to iterfere with identity (the same entity might be in different states)
   - To fix this, we can use the below initializer:
     ```swift
     ForEach(viewModel.cards) { ... }
             // Now viewModel.card must be `Identifiable`.
     ```
   
 - Conforming to `Identifiable`:
   ```swift
   struct Card: Equatable, Identifiable {
     var id: String
   }
   ```
   - In the call-site:
   ```swift
   (Card(content: content, id: "\(pairIndex + 1)a"))
   ```
   - Once `Indentifiable` is implemented, SwiftUI ties a view lifetime to your model identity
     - This allows SwiftUI to move cards when animating, as it knows about identity
 
 - Pretty printing to the console: `CustomDebugStringConvertible protocol`:
   ```swift
   struct Card: Equatable, Identifiable, CustomDebugStringConvertible {
     var debugDescription: String {
       "\(id): \(content) \(isFaceUp ? "up" : "down") \(isMatched ? "matched" : "unmatched")
     }
   }
   ```

 - Flipping the cards (choosing):
  ```swift
  CardView(card)
    .onTapGesture {
      viewModel.choose(card)
    }
  ```
  - Model implementation:
  ```swift
  mutating func choose(_ card: Card) {
    // card is just an immutable copy of the card we actually have in our array.
    // We need to mutate the targetted card inside the model.
    let chosenIndex = index(of: card)
    cards[chosenIndex].isFaceUp.toggle()
  }

  func index(of card: Card) -> Int {
    for index in cards.indices {
      if cards[index].id == card.id {
        return index
      }
    }
    return 0 // FIXME: Bogus
  }
  ```

 - Enums
   - Another data structure inside Swift
   - Can only have discrete states
   - It's a value type (copied when passed around, no shared changes)
   - Allows for cases in the enum to have associated values
   ```swift
   enum FastFoodMenuItem {
     case hamburger(numberOfPatties: Int)
     case fries(size: FryOrderSize)
     case drink(String, ounces: Int)
     case cookie
   }
   
   enum FryOrderSize {
     case large
     case small
   }

   let menuItem: FastFoodMenuItem = .hamburger(patties: 2)
   ```
   - Pattern matching an enum item with `switch`:
   ```swift
   let menuItem = FastFoodMenuItem.hamburger(patties: 2)
   switch menuItem {
     case .hamburger(let pattyCount): print("burger")
     case .fries(let size): print("fries")
     case .drink(let brand, let ounces): print("drink")
     case .cookie: print("cookie")
     // We must cover all cases.
     // Use default for other cases.
     // Switch doesn't fallthrough by default.
   }
   ```
   - We can even switch over a string (which is a collection, not an enum):
   ```swift
   switch s {
     case "goodbye": ...
     default: ...
   }
   ```
   - Enums can have computed variables and methods:
   ```swift
   enum FastFoodMenuItem {
     case ...

     func isIncludedInSpecialOrder(number: int) -> Bool { 
       switch self {
         case .hamburger(let pattyCount): return pattyCount == number
         case .fries, .cookie: return true
         case .drink(_, let ounces): return ounces == 16
       }
     }
     var calories: Int { ... }
   }
   ```
   - Enums can conform to protocols. For example, to get all cases of an enum, we can:
   ```swift
   enum TeslaModel: CaseIterable {
     case X
     case S
     case Three
     case Y
   }

   for model in TeslaModel.allCases {
     reportSalesNumbers(for: model)
   }

   func reportSalesNumbers(for model: TeslaModel) {
     switch model { ... }
   }
   ```

 - Optionals
   - An enum in the standard library
   ```swift
   enum Optional<T> {
     case none
     case some(T)
   }
   ```
   - Use optionals whenever we have variables (e.g properties, parameters, associated values) that can have a value or not
   - This happens often. Swift has syntatic sugar to allow an easier usage (question mark char):
   ```swift
   // Declaring an optional string:
   var hello: String?           // translates to -> var hello: Optional<String> = .none
   var hello: String? = "hello" // translates to -> var hello: Optional<String> = .some("hello")
   ```
   - `Optional`s are **safety feature** in the language, enforcing developers to always *take proper care of values that can be nil*:
     - Swift allows us to **safely unwrap** the optional type, so we can access its value:
     ```swift
     if let someString in optionalStringVar {
       // Use the unwrapped someString from the optional variable (optionalStringVar)
     }
     ```
     - Swift also allows us to **force unwrap** a value. **This is unsafe, and causes crashes if the values isn't there (the optional value is .none)**:
     ```swift
     var hello: String?
     hello! // This will crash our program.
     ```
     - `nil-coalescing` (`??`):
     ```swift
     // If the optional does not have a value, we can use a default one (nil-coalescing):
     let x: String?
     let y = x ?? "foo"
     ```

 - Fixing the `index` method:
   ```swift
   func index(of card: Card) -> Int? {
     for index in cards.indices {
       if cards[index].id == card.id {
         return index
       }
     }
     return nil
   }
 
   mutating func choose(_ card: Card) {
     if let chosenIndex = index(of: card) {
       cards[chosenIndex].isFaceUp.toggle()
     }
   }
   ```

 - Getting rid of `index`:
 ```swift
 mutatinc func choose(_ card: Card) {
   if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
     cards[chosenIndex].isFaceUp.toggle()
   }
 }
 ```

 - Memorize game logic continued:
   - In the model:
   ```swift
   var indexOfTheOneAndOnlyFaceUpCard: Int? {
     get {
       // Only implentation is inside an extension (see extension section below).
       cards.indices.filter { cards[$0].isFaceUp }.only
     }
     set {
       cards.indices.forEach { cards[$0].isFaceUp = $0 == newValue }
     }
   }

   mutating func choose(_ card: Card) {
     if let chosenIndex = cards.firstIndex(where: { $0.id == card.id }) {
       // Only allow players to choose a card that is face down and unmatched
       guard !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched else { 
         return 
       }

       if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
         if cards[chosenIndex].content == cards[potentialMatchIndex].content {
           cards[chosenIndex].isMatched = true
           cards[potentialMatchIndex].isMatched = true
         }
       } else {
         indexOfTheOneAndOnlyFaceUpCard = chosenIndex
       }

       cards[chosenIndex].isFaceUp = true
     }
   }
   ```
   - In the `Card` view, we can display matches:
   ```swift
   // ...
   .opacity(card.isMatched ? 0 : 1)
   ```
   - `only` computed var in Array extension:
   ```swift
   extension Array {
     // Element is Array's generic argument type:
     var only: Element? {
       count == 1 ? first : nil
     }
   }
   ```
