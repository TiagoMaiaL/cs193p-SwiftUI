 # Lecture 8 - Notes

 ## Property observation
 - In your model, you can observe when specific properties change:
 ```swift
 var isFaceUp: Bool {
     willSet { // Means for observing when a property will change and execute some code
         if newValue {
             startUsingBonusTime()
         } else {
             stopUsingBonusTime()
         }
     }
 }
 ```
 - Avoid using the approach above in your views, use `.onChange(of:)` instead:
 ```swift
 Text("\(taps) taps")
     .onChangeOf(of: viewModel.cards) { newCards in
         taps += 1
     }
 ```

 ## Animation

 - Only changes can be animated:
   - ViewModifier arguments
   - Shapes
   - View transitions (existing vs. non-existing)
 - **Always shows changes that already happened**
 - ViewModifiers
   - Primary "change agents" in the UI (opacity, aspect-ratio, position, etc.)
   - **Changes must happen after the view is already displayed in the UI**
   - Most ViewModifier arguments can be animated
 - Transitions:
   - When Views arrive or departs, the entire unit is animated
   - **An arriving view is only animated when its container is already on screen**
   - **The same applies for when a view departs**
   - Use `ForEach` and `if/else` as means for making views come/go to/from the screen
 - Configuring animations:
   - Implicitly (automatic animations) - `.animation(Animation, value:)`
   - Explicitly (manually starting an animation) - `withAnimation(Animation) { /* perform some change */ }`
   - Make views come and go to the UI (including or excluding them in the UI, aka transitions)
   - **Animations only happen if the view is already on screen or if the container for a coming/going View is already there**
 
 ### Implicit animation

 - Automatic
 - All ViewModifiers preceding the animation one will always be animated
 - Animation takes place with the provided duration and curve:
 ```swift
 Text("some text")
     .opacity(card.scary ? 1 : 0)
     .rotationEffect(Angle.degrees(card.upsideDown ? 180 : 0))
     .animation(Animation.easeInOut, value: card) // Whenever card changes, the view is animated accordingly
 ```
 - **A container propagates `.animation` configuration to its subviews**
 - Configure many aspects of the animation through properties in the `Animation` struct
 - **Implicit animations usually are not the primary source of animation behavior**
 - **Use them for a singular view changing, independently of other views**
 
 ### Explicit animation

 - **The usual cause for animations to happen**, usually in response to some user action
 - Create an animation transaction where **a bunch of views are animated as a whole**
 ```swift
 withAnimation(.linear(duration: 2)) {
     // Perform some change
 }
 ```
 - **Almost always wrapped around calls to view model intent methods**
 - **Implicit animations are not overriden by explicit ones**

 ### Transitions
 - Animate views coming and going to and from containers already on screen
 - A pair of modifiers:
   - One of them is the before modification of the View
   - The other is the after modification of the View
 - Asymmetric transition has 2 pairs of ViewModifiers:
   - One for when the view appears
   - Another one for when it leaves the screen
   - We mostly use pre-scanned transitions (`AnyTransition` struct)
 - `AnyTransition`
   - transitions are type erased
   ```swift 
   AnyTransition.opacity
   AnyTransition.scale
   AnyTransition.offset
   AnyTransition.modifier(active:identity:)
   ```
 
