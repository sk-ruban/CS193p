# Lecture 6 - Animation


## Property Observers
* Watch a var and execute code when it changes
```swift
// How it works
var isFaceUp: Bool { 
	willSet { 
		if newValue { 
			startUsingBonusTime() 
		} else { 
			stopUsingBonusTime() 
} } }
```



## @State

* Views are **read only** -> properties in SwiftUI is a let
* `@State` is a temporary Property Obeserver -> Changes will cause View to redraw
* **Permanent states belong in the model**



## Animation

* Can only animate a change that has **already happened**

### Implicit Animation
* Marks a View to **automatically animate** using a duration and “curve”
	* `.linear` - constant rate
	* `.easeInOut` - low, fast, slow
	* `.spring` - bounce at end
* Use modifier `.animation(Animation.type)`
```swift
Text(“👻”) 
	.opacity(scary ? 1 : 0) 
	.rotationEffect(Angle.degrees(upsideDown ? 180 : 0)) 
	.animation(Animation.easeInOut)
// When opacity or rotation changes -> Animation
```

### Explicit Animation
* All eligible changes made as a result of executing a block of code will be animated together
* Usually wrapped around calls to ViewModel Intent functions 
* Doesn’t override implicit animations
* Use `withAnimation(Animation) {...}`

### Transitions
* Animate the arrival/departure of Views with `.transition()`
	* `AnyTransition.opacity` - fades View in and out
	* `AnyTransition.scale` - expand/ shrink View
	* `AnyTransition.offset`  - move the View
* **Not distributed** to container content Views
```swift
ZStack { 
	if isFaceUp { 
		RoundedRectangle()					// default .transition is .opacity					
		Text(“👻”).transition(.scale) 
	} else { 
		RoundedRectangle(cornerRadius: 10).transition(.identity) 
} 
```

### .onAppear
* executes everytime the View appears on screen



## Demo

* use `.repeatForever()` to repeat animation
```swift
.animation(card.isMatched ? Animation.linear(duration: 1).repeatForever(autoreverses: false) : .default)
```
* Use **Localised String Key** for international languages
* `AnimatableModifier` = Animatable + View Modifier
* All shapes are Animatable