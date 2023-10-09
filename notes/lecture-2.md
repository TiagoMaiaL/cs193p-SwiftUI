
 # Lecture 2 - Notes

 ## Memorize UI (continued)

 - In FP we don't have super classes
   - Conformance to View means your struct behaves like one
   - It allows your struct to be used by SwiftUI when reading your declarations
  
 - `some View`
   - The code below is valid:
   ```swift
   var body: Text {
     Text("Hello")
   } 
   ```
   - But notice how the type for VStack can get complicated:
   ```swift
   var body: Text {
     VStack {
       Text("Hello")
       Text("World")
     }
     // Cannot convert return expression of type 'VStack<TupleView<(Text, Text)>>' ...
   }
   ```
   - Depending on the complexity of a View, it would be infeasible to state the explicit return type
     - The SwiftUI view hierarchy is precisely represented by the concrete implementations of the protocol `View`
   - That's the problem *opaque types* solve (`some View`)
   - Notice `TupleView<(Text, Text)>` is a View internal to SwiftUI:
     - It's managed and built by SwiftUI's @ViewBuilder abstraction
     - We don't deal with it directly

 - trailing closures (last argument is a closure)
  ```swift
  // The code below:
  ZStack(alignment: .top, content: {
    Text("Hello")
  })

  // Is the same as:
  ZStack(alignment: .top) {
    Text("Hello")
  }
  ```

 - The compiler synthesizes the initializer of a struct
  ```swift
  struct Card: some View {
    var isFaceUp: Bool = false
    // ...
  }
  
  // Allows for the following initializers:
  Card(isFaceUp: true)
  Card() // isFaceUp has a default value of true (notice the var declarion above)
  ```

 - `@ViewBuilder`s only allows conditionals, variable declarations, function calls returning views, and View initialization
   - Expressions are forbidden:
   ```swift
   ZStack {
     var i = 0
     i += 1 // This throws an error 
     _someView
   }
   ```

 - `let` vs `var`:
   - `let` defines a constant

 - Type inference:
   - Swift is a statically type safe language (knows most types at compile time)
   - The compiler figures out what is the type of your variables and what a function returns
   - Sometimes it can't infer, and we need to give it some clues or explicit type information
   ```swift
   var i = 122
   let rectangle = RoundedRectangle(...)
   let text: String = "some text" // Stating the type here is not needed
   ```

 - SwiftUI tap gestures:
   ```swift
   ZStack {
     Text("😀")
   }.onTapGesture {
     print("tapped")
     // Execute any action in response to an user interaction
   }
   ```

 - SwiftUI `@State` properties:
   - This property wrapper *is used only for view-specific ephemeral states*:
   ```swift
   @State var isFaceUp = false
   ```
   - SwiftUI will keep track of the state changes, redrawing the UI whenever it happens
   - The variable above points to a specific place in memory where the bool info is stored
   - The pointer itself never changes

 - Swift arrays:
   - A `generic` type
   ```swift
   let emojis: Array<String> = ["😃", "😜", "😍", "😎"]
   // Or even simpler:
   let emojis = ["😃" /* ... */]
   ```
   
 - `ForEach` view:
   - `@ViewBuilder` doesn't support looping constructs
   - declares a view for each item of an array or sequence
   ```swift
   ForEach(emojis.indices, id: \.self) { index in
     CardView(content: emojis[index])
   }
   ```

 - `Button` view:
   ```swift
   Button("Add Card") {
     cardCount += 1
   }
   ```
   - Also allows a specific view as its label:
   ```swift
   Button(action: {
     /* ... */
   }, label: {
     Image(systemName: "rectangle.stack.badge.minus.fill")
       .imageScale(.large)
       .font(.largeTitle)
   })
   ```

 - `Spacer` view:
   - Fills all available and empty space in the layout
   ```swift
   HStack {
     Button(...)
     Spacer()
     Button(...)
   }
   ```

 - Some refactoring tips:
   - Important Views for the UI should be in their own struct (e.g `CardView`)
   - Is your body with many lines of code?
     - Consider creating computed variables for each subcomponents:
     ```swift
     // Body can then invoke this variable when declaring it UI
     private var cards: some View { /* ... */ }
     ```
     - Consider creating a factory function:
     ```swift
     private func cardCountAdjuster(by offset: Int, symbol: String) -> some View {
       Button(action: {
         cardCount += offset
       }, content: {
         Image(systemName: symbol)
       }
     }
     ```
   
 - `LazyVGrid` view:
   - More appropriate for displaying the cards:
   ```swift
   LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]) {
     ForEach(...)
   }
   // or adaptive:
   LazyVGrid(columns: [GridItem(.adaptive(minimum: 50))]) {
     ... 
   }
   ```
   - Occupy as little space as possible

 - `ScrollView`:
   ```swift
   ScrollView {
     cards
   }
   ```
