## Lecture 01
* `some View` allows for any struct to be returned as long as it conforms to the View protocol.
* `@ViewBuilder` combines multiple views and returns a single View.
	* Expressions are forbidden.
```swift
@ViewBuilder
var myView: some View {
    Image(systemName: "globe")
    Text("some text")
}
```

## Lecture 02
* Trailing closures (last argument is a closure).
```swift
ZStack(alignment: .top) {
  Text("Hello")
}
```
* With a `@State` var, SwiftUI will keep note of changes and redraw the UI.
* In a `LazyVGrid` views are only created when SwiftUI needs to display them.