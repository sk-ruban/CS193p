# Lecture 3 - Reactive UI Protocols Layout


## Demo

* *Cmd-click* to rename across files
* All **arguments** in functions are constants
* `// TODO`: shows up in bar above for user to come back & edit

For Value Types,

* All functions that modify its own variables have to be **mutating**  

* All inits are `mutating`

  

* For `ObservableObject` Classes, `@Published` **publishes changes** in Model to the View
```swift
// View Model
class EmojiMemoryGame: ObservableObject {
    @Published private var model: MemoryGame<String>
		// Changes to model should trigger view reloads.
```

* `@ObservedObject` to **receive** `@Published` changes
```swift
// View
struct EmojiMemoryGameView: View {
    @ObservedObject var viewModel: EmojiMemoryGame
```



## Protocols

* Protocol is a “stripped down” struct/class with **no storage**
* Structs / classes can **inherit multiple protocols**
  * Every protocol's var & func **must** be implemented
* Protocol is a type
```swift
protocol Moveable {
		func move(by: Int) 
		var hasMoved: Bool { get }
		var distanceFromStart: Int { get set }}
}

struct PortableThing: Moveable {
		// must implement move(by:), hasMoved and distanceFromStart
}
```

### Protocol Extensions
* Can add implementations to a protocol using an extension to the protocol
* Can also add extensions to Classes / Structs
```swift
extension Moveable { 
		func registerWithDMV() { /* implementation here */ }
} 
```

### Generics & Protocols

```swift
protocol Greatness {
  	func isGreaterThan(other: Self) -> Bool
  	// Self is the type of thing implementing the protocol
}

extension Array where Element: Greatness {
		// ...  
}
```



## Layouts

### Space Appointment

1. Container Views offer space to the Views inside
2. Views choose their size
3. Container Views then position the Views inside of them

* Choice of who offer spaces can be overidden with `.layoutPriority(Any Number > 0)`
* `GeometryReader` knows how much space is offered to it
* `.edgesIgnoringSafeArea()` allows drawing in safe areas to increase size of View up to the edges