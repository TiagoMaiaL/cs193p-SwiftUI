
 # Lecture 1 - Notes

 ## Course learning goals
 
 - Swift programming language
 - Functional programming
 - Reactive UI development with MVVM architecture (SwiftUI)
 - OO Databases
 - Real life application of various CS concepts

 ## Subjects

 ### Assignment 0 (setup Xcode)

 - Download and install Xcode
 - Configure a GitHub account
 - Configure an Apple id

 ### XCode
 - Starting Xcode and creating an iOS project
 - Xcode sections (top bar, simulators, project navigation, inspector, etc.)
 - Preview panel
 - Start building a game (Memorize demo)

 ### Swift and SwiftUI
 - `struct`s
   - Don't for allow object oriented programming
   - Contains methods and properties
   ```swift
   struct ContentView: View { ... }
   ```
 - `protocol`s (e.g: `View`)
   - Allows for functional programming
   - Swift is also called a protocol oriented programming language
   - protocols can describe the abstract behaviors of specific types
   ```swift
   // ContentView behaves (functionality) like a View
   struct ContentView: View { ... }
   ```
 - Object Oriented Programming vs Functional Programming
   - OOP has data encapsulation in its roots
   - FP is more about behavior encapsulation (one characteristic)

 - Behaving like a `SwiftUI.View` (conforming to the protocol
   - Requirements to fulfill: implement a `body` computed property
   - Gains lots of capabilities applicable only to `View`s
     - (Setting colors, borders, positions, frames, etc.)
   ```swift
   var body: some View {
       Text("Hello world")
   }
   ```

 - Variable declarations:
   ```swift
   var i: Int // i is an Int
   var s: String // s is a String
   var computed: String {
       return someComputedString
   }
   ```

 - `some View`:
   - Any struct can be returned, as long as it behaves like a View
   - Swift executes the code, see what it returns, and uses that

 - What is a `SwiftUI.View`?
   - Conceptually:
     - A rectangular area in the screen, capable of drawing specifc content inside it
     - Part of your user interface
     - Capable of handling gestures
   - In Swift terms:
     - A protocol describing how a View behaves
     - structs say they behave like a View when conforming to this protocol
     - They can then be used by SwiftUI, when we declare what should be on screen
     - Structs must provide a computed var: `var body: some View`
       - Lego analogy
         - A view is composed of other subviews acting as building blocks
         - SwiftUI provides:
           - Primitive views: `Text, Image, Button`, etc.
           - Layout composotition views: `VStack, HStack, ZStack, Spacer`, etc.
         - In the `View`'s `body`, a struct returns which other subviews compose it
         - Once your struct behaves like a View, it then can be used as building block for other higher level constructs (other views that use it)

 - Creating a struct:
   - To initialize it: `MyStruct(/* params */)`
   ```swift
   Image(systemName: "globe")
   ```

 - In SwiftUI and FP it's common to receive functions as arguments:
   ```swift 
   VStack(spacing: 10) {
       // These curly braces are a function in charge of declaring what views
       // should be inside the VStack.
       // In more technical terms, these functions return a View composed inside this function.
       Image(systemName: "globe")
       Text("Hello world")
   }
   ```

 - @ViewBuilder
   - It allows us to compose Views using a declarative style
   - You can apply it to functions and computed variables
   - Inside a `@ViewBuilder` annotated context we can:
     - Declare views
     - Use conditionals to declare if views should be displayed or not
     - Declare variables for those views
   ```swift
   @ViewBuilder
   var myView: some View {
       Image(systemName: "globe")
       Text("some text")
       // @ViewBuilders combines the above declared views and returns a single View, containing both of them
   }
   ```

 - View modifiers
   - Functions that modify views, by wrapping the original one, modifying it somehow, and returning a new View
   - You get free access to them when constraining your types to the View protocol (saying it behaves like a View)
   - This is a powerful mechanism in Swift allowing function implementations to be shared
   ```swift
   Image(...)
       .imageScale(.small)
       .foregroundColor(.green)
   ```
   - Composition Views can pass some modifier options to their subviews (modifier scope):
   ```swift
   VStack { ... }
       .font(.largeTitle)
   // All subviews get a large title font
   ```

 - Memorize Demo
   - Building the card UI in SwiftUI
