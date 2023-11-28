 # Lecture 6 - Notes

 ## Layout

 - How does swift UI distribute the available space between the views?
   1. SwiftUI offers all available space to its root view (normally your container views)
   2. Container views offer some or all available space to its subviews
   3. Views then decide what size (from the offered space) they want to take (**views choose their own size**)
   4. Container views position its subviews (**positioning is done by containers**)
     4.1 There's a protocol that can be implemented to customize layout

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
   - Only takes as much space as needed
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
   - Will be size to the circle shape (fully flexible)

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

 
