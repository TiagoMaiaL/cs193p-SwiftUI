 # Lecture 3 - Notes

 ## MVVM (*M*odel-*V*iew-*V*iew*M*odel)

 - A design paradigm (architecture)
 - Separates logic and data from the user interface
   - SwiftUI is architected with this separation concept in mind
   - A ViewModel acts as a gatekeeper
 - Logic and data are said to be the *Model*
   - The UI (or View) displays the model state and data
     - > A visual manifestation of the model
   - Can be a struct, SQL database or other things holding data and business logic
   - Examples of model state and data: isFaceUp, cardCount, content, etc.
 - SwiftUI redraws the UI whenever a Model that affects the UI changes
 
 ### Connecting the UI to the model (approaches)

 1. SwiftUI `@State`: It should be used only for transitory state particular to a view
   - Might be used by simple views that only display model info.
 2. ViewModel: 99% of the cases. It knows how to do SQL or HTTP calls, for example. Things like these shouldn't be in the UI.
 3. Hybrid of 1 and 2: A ViewModel that allows the model to be directly accessed by a View

 ### Components in MVVM

 #### Model
 - UI independent
 - Data + Logic
 - The source of truth
 
 #### View
 - Supposed to be stateless
   - @State should be used for transient state information belonging just to the view:
     - e.g: A transition state, a specific mode for the view
 - Data can flow from the model to the view (read-only)
 - Reflects the Model
 - Declared (declarative programming vs. imperative)
   - Declarative is considered to be a paradigm that sits inside Functional Programming
   - We declare *what*'s on screen at a given time
   - *What* vs *how*
 - Reactive
   - Reacts to the changes in the model and gets redrawn accordingly
   - `@ObservedObject`, `ObservableObject`, `@Published`
   - `@Binding`
   - `.onReceive`
   - `@EnvironmentObject` and `.environmentObject()`
   - `@Observable` (WWDC 2023)
 - Changes to the view can affect the model
   - Calls intent function in the view model (e.g choose a card, follow a topic, etc.)

 #### ViewModel
 - Binds View to the Model
 - Interprets the model so the View can easily consume it
 - Acts as Gatekeeper protecting the Model
 - Data flows from the Model to the ViewModel and then to the View
   - The ViewModel detects changes in the Model
   - It then publishes that there are changes to be consumed in the model
   - The view then automatically gets the changes and redraws the specific View affected by it (reactive)
 - Processes user intent from the View
   - Changes the model, triggering the whole observation mechanism, making views to react to it

 ## Swift type system (varieties of types):
 
 ### `struct` vs. `class`:
 - *They encapsulate data*
 - Have stored variables (aka properties)
 - Have computed variables 
 - Have constants
 - Have functions (aka methods)
 - Initializers (used for creating an instance of both)
 - Strong differences:
   - structs have *value semantics*, while classes have *reference semantics*.
     - value semantics:
       - The value is right there in the variable
       - Swift "makes copies" of the struct and values when you pass it around (e.g to other variables or functions)
         - Under the hood, swift also copies on write (as a performance action)
       - Changes to one value aren't shared to a different one
     - reference semantics:
       - We have a pointer (or reference) to a value in memory
       - Changes are all shared between references
       - side-effects of many pieces of code modifying the same value
       - Swift counts the references to know when they should get removed from memory (Automatic Reference Counting or ARC)
   - structs are more suitable for Functional Programming and don't allow inheritance
     - Provability: prove a piece of code does what it should do, not matter what
     - No shared pointers doing side-effects
     - Functions can have total control over that specific value
   - classes are more suitable for OOP, allowing inheritance
   - Mutability:
     - In structs it's explicit (var or let)
     - Classes are always mutable
   - Most of the times we should start modelling our code with structs
   - For ViewModels, though, we want to use classes, as they can be shared with multiple views

 ### Generics
 - Don't care types (or type agnostic)
 - Arrays don't know which specific type of element they bear, it adjusts itself for every possible kind of elements
 ```swift
 struct Array<Element> {
   ...
   func append(_ element: Element) { ... }
 }
 ```
 - It basically refers to an unknown type as Element, but it can be anything:
 ```swift
 let ages = Array<Int>()
 ages.append(30)
 ages.append(21)
 ```
 - `Element` in the above example is said to be a *Type parameter*

 ### Protocols
 - We can see these as *contract*s specifying how things must *behave*
 - Specific pieces of your code will then interact with entities *conforming* to these contracts (behaving in a certain manner)
 - Example: 
   - SwiftUI manipulates instances of types *conforming* to (or behaving like) `View`s. 
   - If we wish to create custom Views, we need to create a new struct that conforms to it.
 struct MyView: View { ... }
 - These contracts specify what functions and variables a specific type must have for it to conform to fulfill this contract:
 ```swift
 protocol Moveable {
   func move(by: Int)
   var hasMoved: Bool { get }
   var distanceFromStart: Int { get set } 
 }
 ```
 - Instances then *implement* this protocol in order to *conform* to it
 ```swift
 struct PortableThing: Moveable { 
   // TODO: Implement the requirements in the protocol
 }
 ```
 - Once a struct conforms to it, we can say that *it behaves* like a `ProtobleThing`, or we can also say *it is* a `PortableThing`
 - Protocols can behave as other protocols 
 - *protocols are types*

 #### Constrains and gains

 - Protocols can provide default implementations through the use of extensions:
 ```swift
 extension SomeProtocol {
   var someProperty: SomeType { /* ... */ }
   func someMethod() [
     // ...
   }
 }
 ```
 - When a struct conforms to a protocol, it gains `someProperty` and `someMethod` for free
 - Protocols can also provide default implementations for some of its required methods and properties
 - SwiftUI makes extensive use of this feature of protocols:
   - When a struct conforms to View, it gains lots of modifiers for free

 #### Generic type constraints

 ```swift
 struct Array<Element> where Element: Equatable { ... }
 ```
 - In the above example, Array can only be used with types that conform to Equatable
 - This idea can also be applied when adding conditional extensions, with functions that are only added when a certain condition is true:
 ```swift
 extension Array where Element: Movable {
   func move(by distance: Int) { 
     for element in self {
       element.moveBy(distance)
     }
   }
 }
 ```

 ### Functions are types
 ```swift
 (Int, Int) -> Bool   // Takes two integer arguments and returns a boolean
 (Double) -> Void     // Takes a Double and returns nothing
 () -> Array<String>  // Takes no arguments and returns an array of strings
 () -> ()             // Takes no arguments and returns nothing
 ```
 - Functions are first-class citizens in swift:
   - we can define variables that hold functions:
   ```swift
   var operation: (Double) -> Double
   ```
   - We can define arguments that are itself other functions:
   ```swift
   func map(_ transform: (SomeType) -> (OtherType)) { /* ... */ }
   ```
   - We can define functions that return other functions:
   ```swift
   func someMethod() -> (SomeType) -> SomeType { /* ... */ }
   ```
 - Slides sample:
 ```swift
 var operation: (Double) -> Double

 func square(operand: Double) -> Double {
   return operand * operand
 }

 operation = square
 let result1 = operation(4) // 16
 
 operation = sqrt // built-in
 let result2 = operation(4) // 2
 ```

 ### Closures

 - Inline functions
 - They *capture* the environment around them
 - e.g: `@ViewBuilders`, `onTapGesture`, etc.

 ## Demo

 - Start applying MVVM to Memorize
   - Model: `MemorizeGame<CardContent>`, `MemorizeGame.Card`
   - ViewModel: `EmojiMemoryGame`, `EmojiMemoryGame.model` of type `MemorizeGame<String>`
