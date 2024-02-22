 # Lecture 7 - Notes

 ## Demo interlude

 - Move `CardView` to its own file
 - Dealing with constants
   - One approach is to name them in the scope of the view, as a property:
   ```swift
   private let spacing: CGFloat = 4
   ```
   - When there are multiple constants, one can create a namespace:
   ```swift
   private struct Constants {
       static let cornerRadius: CGFloat = 12
       static let lineWidth: CGFloat = 2
       // ...
       struct FontSize {
           static let largest: CGFloat = 200
           static let smallest: CGFloat = 10
           // ...
       }
   }
   ```
   - One can use enums instead of structs (enums don't allow subclasses):
   ```swift
   private enum Constants {
       // ...
       enum FontSize {
           // ...
       }
   }
   ```
   - We can also add static functions inside the namespace

 ## Shapes

 - Is a protocol inheriting from View
 - Shapes are also views
 - By default, shapes are drawn by filling
 - One can change this by using the `.stroke()` view modifier
 - `.fill()` receives an argument conforming to `ShapeStyle`
 - Implement `path(in rect: CGRect) -> Path` to draw anything you want
 ```swift
 struct Pie: Shape { // Reusable pie shape
     func path(in rect: CGRect) -> Path {
         // ...
     }
 }
 ```
 - One can also draw a shape by using a handy initializer:
 ```swift
 Shape { path in
     // shape drawing code
 }
 ```
 - It's possible to animate a shape
 - There are some view modifiers allowing us to animate our views (for next lectures)
 - Full code [here](https://web.stanford.edu/class/cs193p/Spring2023/Pie.swift)
 
 ## `ViewModifier`

 - It's a protocol
 ```swift
 protocol ViewModifier {
     func body(content: Content) -> some View {
         return // modified content view
     }
 }
 ```
 - Every View has a `modifier(ViewModifier)` function, taking a value conforming to the `ViewModifier` protocol
 - Example: `Cardify` modifier
 - Full code [here](https://web.stanford.edu/class/cs193p/Spring2023/Cardify.swift)

 ## Protocols (Part II)

 - One of its most used features is code sharing through extensions
   - Add an implementation to a protocol
   - This is how View has all its modifiers for free
   ```swift
   extension View {
       func cardify(isFaceUp: Bool) -> some View {
           modifier(Cardify(isFaceUp: isFaceUp))
       }
   }
   ```
   - Can be used to provide default implementation of specific methods required in the protocol
   - Example: the `filter` function can be used in `Array`s, `Range`s, `String`s, `Dictionary` and others
     - This happens because all these types implement the `Sequence` protocol
     - And `filter` was added as an extension to `Sequence`
     - All its concrete implementations get `filter` for free

 - Generic protocols
   - Protocols can have don't care types:
   ```swift
   protocol Identifiable {
       associatedtype ID
       var id: ID { get }
   }
   ```
   - Implementations will provide their own ID type
   - We must have a type that is hashable, we need to constrain our generic type:
   ```swift
   protocol Identifiable {
       associatedtype ID where ID: Hashable
       var id: ID { get }
   }
   ```
 - `some` and `any`:
   - `some`
     - Used with a protocol to pass values opaquely in or out of a function/var
     - Opaque means we know it conform to the protocol but nothing else (example: when we return `some View`)
     - Can be used when declaring parameter types or return values
     - All paths must return a value of the same type (usually ViewBuilder makes this a lot easier, and all modifiers return some modified View)
     - When using as a parameter:
     ```swift
     // This declaration
     func fill<S>(_ whatToFillWith: S) -> View where S: ShapeStyle

     // Can be written as
     func fill(_ whatToFillWith: some ShapeStyle) -> View
     ```
   - `any`:
     - A way of holding heterogeneus arrays of elements conforming to a specific protocol
     - For more complex protocols (Self-referential like Equatable or generic ones), we can't use them as a type unless using `some` or `any` (but why?)
     ```swift
     let ids = [any Identifiable]()
     ```
     - A box of `Identifiable` (it can contain `any` different type of Identifiable concrete implementation), this is similar to the concept of type erasure
     - To use the id from the array above, one need to use `some`:
     ```swift
     func printId(of identifiable: some Identifiable) { print(identifiable.id) }
     ```
     
