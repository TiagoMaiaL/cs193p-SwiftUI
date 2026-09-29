 # Lecture 6 - Notes

 ## Layout

 - How does swift UI distribute the available space between the views?
   1. SwiftUI offers all available space to its root view (normally your container views)
   2. Container views offer some or all available space to its subviews
   3. Views then decide what size (from the offered space) they want to take (**views choose their own size**)
   4. Container views position its subviews (**positioning is done by containers**)
   
   - Note: there's a protocol that can be implemented to customize layout

 - `HStack` and `VStack` (the most basic kinds of layouts):
   - Stacks divide their offered space and then offer them to its subviews
   - When offering space to its subviews, it first does it to the least flexible ones
     - Example of inflexible views: `Image`, `Text`
     - Example of flexible views: `RoundedRectangle` or most shapes
   - After a subview chooses a space, stacks remove it from the available space
   - It then continues to other subivews according to its flexibility
   - Once all views chose their sizes, stacks then determine their own size to their parent
   - Valuable views for layout:
     - `Spacer`: draws nothing and takes up all offered available space
     - `Divider`: draws a dividing line, takes the minimum space needed to fit
   - **Overriding "flexibility" in stacks**: `.layoutPriority(Double)`
     - Use this modifier if a view needs to be sized first:
     ```swift
     HStack {
         Text("Important").layoutPriority(100) // Users must be able to read the entire text
         Image(systemName: "arrow.up")
         Text("Unimportant")
     }
     ```
   - alignment (e.g `.leading`, `.trailing`, `.firstTextBaseline`)
     - alignment can be customized
   - `LazyHStack` and `LazyVStack`:
     - Only build the views once they are visible
     - They don't take all available space offered to them
     - Use these with `ScrollView`

 - `LazyHGrid` and `LazyVGrid`:
   - Only take as much space as needed
   - Get information on how to size its subviews using their `columns` `init` parameter
   - The other direction shrinks or expands based on how many views there are

 - `Grid` (e.g spread sheet, tables)
   - Allocates spaces to its views in all directions
   - Different alignment options for columns and rows

 - `ScrollView`: takes up all available space

 - `ViewThatFits`:
   - Receives a list of subviews and chooses the most appropriate one according to the space
   - Useful for landscape vs. portrait, or dynamic types

 - `Form` and `List`, `OutlineGroup` and `DisclosureGroup`:
   - "Really smart `VStacks`" (scrolling, selection, hierarchy)

 - Customizing layouts: `Layout` protocol

 - `ZStack`:
   - Sizes itself to fit their subviews
   - If one of the subviews is fully flexible, `ZStack` will also be
   - Its size will be the same as the one of its largest subview

 - `.background` view modifier:
   ```swift
   Text("hello").background(Rectangle().foreground(.red))
   ```
   - In the above code, rectangle is sized according to the text (it's different from ZStack)

 - `.overlay` view modifier:
   ```swift
   Circle().overlay(Text("Hello"), alignment: .center)
   ```
   - Will be sized to the circle shape (fully flexible)

 - Modifiers
   - Some modifiers are involved in the layout process. Examples:
     - `.padding`: removes the padding from the space offered to its modified subview
     - `.aspectRatio`: 
       - Takes the space offered to it and chooses its size respecting the ratio, making sure it fits (`.fit`)
       - When `.fill` is used, it might use more space then what was offered to it, always respecting the ratio

 - `GeometryReader`:
   - Takes up all space available to it, reporting it back to the subviews
   ```swift
   GeometryReader { proxy in ... }
   ```

 - Safe Area:
   - Parts of the screen views shouldn't be positioned (e.g iPhone X notch, or dynamic island)
   - Surrounding views can also introduce safe areas that subviews shouldn't draw in
   - Ignoring safe ares:
     ```swift
     ZStack { ... }.edgesIgnoringSafeArea([.top])
     ```

 ## Layout demo (size cards to fit offered space)

 - Make the cards grid fit into the screen, without the need for a scroll view
 - We begin by adding a geometry reader, so that we can get information about the available space:
 ```swift
 GeometryReader { geometry in
     LazyVGrid(columns: ...) { ... }
 }
 ```
 - From the informed space (`GeometryProxy`), we can compute the proper width of a card:
 ```swift
 let gridItemSize = gridItemWidthThatFits(
     count: viewModel.cards.count, 
     size: geometry.size, 
     aspectRation: 2/3
 )
 LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) { ... }
 ```
 - How to calculate an item width that fits (implementation):
 ```swift
 func gridItemWidthThatFits(
     count: Int,
     size: CGSize,
     atAspectRatio aspectRatio: CGFloat
 ) -> CGFloat {
     let count = CGFloat(count)
     var columnCount = 1.0
     repeat {
         let width = size.width / columnCount
         let height = width / aspectRatio
         let rowCount = (count / columnCount).rounded(.up)
         
         if rowCount * height < size.height {
             return (size.width / columnCount).rounded(.down)
         }

         columnCount += 1
     } while columnCount < count

     return min(size.width / count, size.height * aspectRatio).rounded(.down)
                                    // Why does size.height * aspectRatio work in this case?
 }
 ```

 - `ViewBuilders`
   - Allows us to declare a view using constructs that wouldn't be allowed in normal swift code (due to invalid syntax)
     - We can declare lists of views that get glued by the ViewBuilder:
       - It might be a TupleView (for two or more views, this is usually more used in the implementation side of SwiftUI)
       - It can be a _ConditionalContent (private SwiftUI view for views that should be present for a specific condition)
   - To allow View declaration inside a var or func code, we annotate it with `@ViewBuilder`:
   ```swift
   @ViewBuilder
   var cards: some View {
       // Once we declare our views here, @ViewBuilder builds an underlying View that's provided to SwiftUI
   }
   ```
   - `body` is an implicit `@ViewBuilder`, as it's declared in the protocol

 - Let's create a grid (a generic view) that makes its items fit within its available space
 ```swift
 struct AspectVGrid<Item, ItemView>: View where Item: Identifiable, ItemView: View {
     var items: [Item]
     var aspectRatio: CGFloat = 1
     @ViewBuilder var content: (Item) -> ItemView

     init(_ items: [Item], aspectRatio: CGFloat, @ViewBuilder content: @escaping (Item) -> ItemView) {
         self.items = items
         self.aspectRatio = aspectRatio
         self.content = content
     }

     var body: some View {
         GeometryReader { geometry in
             let gridItemSize = gridItemWidthThatFits(
                 count: items.count,
                 size: geometry.size,
                 atAspectRatio: aspectRatio
             )
             LazyVGrid(columns: [GridItem(.adaptive(minimum: gridItemSize), spacing: 0)], spacing: 0) {
                 ForEach(items) { item in
                     content(item)
                         .aspectRatio(aspectRatio, contentMode: .fit)
                 }
             }
         }
     }

     // ... gridItemWidthThatFits implementation, the same as above
 }
 ```
