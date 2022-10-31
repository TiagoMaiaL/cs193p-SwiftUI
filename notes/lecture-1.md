
 # Lecture 1 - Notes

 ## What's covered

 - What's Xcode and how to use it
 - How to use the simulator
 - Memorize demo - creating an initial app
 - SwiftUI
   - How previews work
   - UI files vs logic files - importing SwiftUI
   - `struct`s are data structures having properties and methods
   - No traditional inheritance (OOP)
   - More associated to functional programming
   - `struct`s **behaving** like `View`s
   - In functional programming we are concerned about **behaviors**, abstracting implementation details
   - If a struct behaves like a `View`, it get's access to an entire collection of new methods or properties
   - But it needs to attend a requirement: provide a computed `var body`
   - Lego analogy: bulding bigger views from native ones, combining them in their bodies
   - Encourages the creation of modular small views, which can then be combined into more complex ones (decomposition)
   - Native views:
     - Combiners (`HStack`, `VStack`, `Grid`, `List` ...)
     - Regular ones (`Text`, `Button`, `Image`, `RoundedRectangle` ...)
   - Computed vars have a function associated to them
   - Functions are everywhere in functional programming
   - usage of some View - The compiler discovers and replaces the **actual** type when compiling
