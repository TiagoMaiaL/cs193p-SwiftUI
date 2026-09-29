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
 - Use `.transition` to specify specific types of transition for a view:
 ```swift
 Text("...").transition(AnyTransition.scale)
 ```
 - `.transition` does not redistribute it to a container's child views, only if you apply it to `ForEach` or `Group`
 - **`.transition` only specifies what transition to use, it's not an action**
 - It's possible to change the transition animation properties using `transition.animation(...)`

 ### Matched Geometry Effect

 - It solves the problem of animating a view to move into another container
 - We need two views in different containers
 - **We remove the first view, while at the same time we add the second one (each with its own different container view)**
 - We then match the geometry of these views (example: dealing cards out)
 ```swift
 .matchedGeometryEffect(id: ID, in: Namespace) // ID is Hashable
 ```
 - Declare the namespace:
 ```swift
 @Namespace private var myNamespace
 ```
 - **Make sure only one view is present at the same time to make this effect work**
 - It's possible to match geometries when both Views are on screen (this will be used for assignment 4)

 ### Kicking off animations
 
 - `.onAppear { }`
 - It's called when the view is on screen

 ### How animatinos work

 - Animated shapes and view modifiers
 - The animations is divided based on the duration and curve
 - The view modifier makes sure to draw the view according to the current animation state
 - To make our Views and modifiers work with the animation systems, we need to implement the `Animatable` protocol

 ### `Animatable` protocol

 - Has only one requirement: `var animatableData: Type`
 - Type is generic, and must implement `VectorArithmetic`
 - Usually we'll deal with `Floats`, `Doubles`, `CGFloats`
 - We might also deal with `AnimatablePair`:
   - It combines two `VectorArithmetic`s into one // TODO: Review this later on by playing around with the example app
 - `animatableData` is a read/write property:
   - When the animation system writes to it, it's telling your shape/property wrapper what portion of the animation to draw
   - When the animation system gets its value, it's figuring out what's the start and end points of the animation

 ## Demos

 - Make shuffle animate explicitly:
 ```swift
 withAnimation { // We usually don't want custom curves, we want the default ones from the system
     viewModel.shuffle() // We are changing the position of the cards, which changes the .position of the views. This change in animated.
 }
 
 // ...

 withAnimation {
     viewModel.choose(card)
 }
 ```
 - Animate the card emoji to flip:
 ```swift
 Text(card.content)
     ...
     .rotationEffect(.degrees(card.isMatched ? 360 : 0))
     .animation(.easeInOut(duration: 2), value: card.isMatched) // Here we do an implicit animation, it takes priority over the explicit one
 ```
 - We can add a custom animation and name it:
 ```swift
 extension Animation {
     static func spin(duration: TimeInterval) -> Animation {
         .linear(duration: 1).repeatForever(autoreverses: false)
     }
 }
 ```
 - Flipping the card:
 ```swift
 // Apply a view modifier for it, which happens to be Animatable (most of them are)
 .rotation3DEffect(.degrees(isFaceUp ? 0 : 180), axis: (0, 1, 0)) // The axis represents the direction of the animation
 ```
 - Make the cardfy modifier properly show its faces in the appropriate moments:
 ```swift
 struct Cardify: ViewModifier, Animatable {
     init(isFaceUp: Bool) {
         rotation = isFaceUp ? 0 : 180
     }

     var isFaceUp: Bool {
         rotation < 90
     }

     var animatableData: Double {
         get { rotation }
         set { rotation = newValue }
     }

     func body(content: Content) -> some View {
         // ...
         .rotation3DEffect(.degrees(rotation), axis: (0, 1, 0))
     }
 }
 ```
 - Implement scoring in the model for Memorize
 - In the view:
 ```swift
 var score: Int { model.score }

 var body: some View {
     VStack {
         cards
             .foregroundColor(viewModel.color)
         HStack {
             Text("Score: \(viewModel.score)")
             Spacer()
             Button("Shuffle") {
                 // ...
             }
         }
     }
 }
 ```
 - Create the flying number text:
 ```swift
     CardView(card)
         .overlay(FlyingNumber(number: scoreChange(causedBy: card)))
         ...
 ```
 - Start implementing `FlyingNumber`, more in the next lecture
