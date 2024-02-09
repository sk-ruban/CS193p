# Lecture 9 - Data Flow
## Property Wrappers
* `@Something` are property wrappers
* PW is just a struct which **provides template behaviour** for the vars they wrap
* Access `projectedValue` using `$`

```swift
@Published var emoji: EmojiArt = EmojiArt()

// is the same as ...
struct Published {
  var wrappedValue: EmojiArt
  var projectedValue: Publisher<EmojiArt, Never> // Never Fails
}

// makes this vars available
var _emojiArt: Published = Published(wrappedValue: EmojiArt())
var emoji: EmojiArt {
  get { _emojiArt.wrappedValue }
  set { _emojiArt.wrappedValue = newValue }
}
```

### @State

* Stores the wrappedValue in the heap
* `$` is a Binding to the value in the heap

### @ObservedObject
* Redraws the View when it receives a change
* `$` is a Binding to ViewModel

### @Binding
* Bound to something else (ie. gets and sets the value from some other source)
* `$` is a Binding to self
* It is about having a **single source of data**
* Binding to a constant with `Binding.constant(value)`

### @EnvironmentObject
* Same as @ObseveredObject but passed in a different way
* **Visible to all Views in your body**
* One @EnvironmentObject wrapper per ObservableObject type per View
* wrappedValue obtained via `.environmentObject()`

```swift
let myView = MyView().environmentObject(theViewModel)
// ...vs...
let myView = MyView(viewModel: theViewModel)

// In the View
@EnvironmentObject var viewModel: ViewModelClass
// ...vs...
@ObservedObject var viewModel: ViewModelClass
```

### @Environment

* Unrelated to @EnvironmentObject - Manages the Environment
* `@Environment(keypath)`



## Publishers

* Object that emits **values** and a **possible failure object** if it fails `Publisher<Output, Failure>`
* Failure can be Never

### Listening to Publishers

* Execute a `.sink` closure whenever the Publisher publishes
* Returned thing implements the `Cancellable` protocol
  * you can `.cancel()` it to stop listening
  * as long as `var cancellable` exists the `.sink` subscriber will be alive

```swift
cancellable = $myPublisher.sink(
	receiveCompletion: { result in ...}  // Can ignore if failure is never
  receiveValue: { thingThePublisherPublishes in ...}
)
```

* A View can listen to a Publisher too `.onReceive(publisher){ }`



## Demo

* Get / Set vars can be substitutes for functions

* For Publishers in Inits, `var Cancellable` necessary for the `.sink` to continue running

  ```swift
  // needs to import Combine
  private var autosaveCancellable: AnyCancellable?
  
  init(id: UUID? = nil) {
      self.id = id ?? UUID()
      let defaultsKey = "EmojiArtDocument.\(self.id.uuidString)"
      emojiArt = EmojiArt(json: UserDefaults.standard.data(forKey: defaultsKey)) ?? EmojiArt()
      autosaveCancellable = $emojiArt.sink { emojiArt in
          print("\(emojiArt.json?.utf8 ?? "nil")")
          UserDefaults.standard.set(emojiArt.json, forKey: defaultsKey)
      }
      fetchBackgroundImageData()
  }
  ```

* To receive Published Objects `$` from View Model, use `.onReceive`

  ```swift
  // View
  .onReceive(self.document.$backgroundImage) { image in
      self.zoomToFit(image, in: geometry.size)
  }
  ```

* Use `EmptyView()` for the Label of a Stepper if no label required

  ```swift
  Stepper(onIncrement: {
      self.chosenPalette = self.document.palette(after: self.chosenPalette)
  }, onDecrement: {
      self.chosenPalette = self.document.palette(before: self.chosenPalette)
  }, label: { EmptyView() })
  ```

* `.fixedSize` sizes a View to fit

* @State should always be **private**

* @Binding **cannot be private**