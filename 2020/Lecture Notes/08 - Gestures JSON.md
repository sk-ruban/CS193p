# Lecture 8 - Gestures JSON
## Persistance

* Ways to store data
  * File System - **FileManager**
  * SQL Database - **CoreData**
  * **iCloud**
  * Database in the cloud - **CloudKit**
  * Persistant Dictionary - **UserDefaults**

### UserDefaults

* For **lightweight** information (NEVER for documents)
* Only stores a *Property List*
	* Any combination of String, Bool, Int, Date etc.

* `Codable` converts structs into Data objects (part of Property List)
* Uses alot of `Any` Type - need to **Type Cast** (... as ...)

```swift
// Create Instance of UD
let defaults = UserDefaults.standard

// Storing Data
defaults.set(object, forKey: “SomeKey”) //  object must be a Property List

// Retrieving Data
let i: Int = defaults.integer(forKey: “MyInteger”)
let b: Data = defaults.data(forKey: “MyData”)
let u: URL = defaults.url(forKey: “MyURL”)
let a = array(forKey: “MyArray”) // returns Array<Any>
```



## Gestures

* Use `myView.gesture(theGesture)` 
* Create a Gesture using a func or var

```swift
// Creating a Gesture
var theGesture: some Gesture {
  return TapGesture(count: 2)
}
```

### Discrete Gesture

* A gesture that happens **all at once** (eg. Taps)
* Use `.onEnded` to "do something" after a Gesture
* Also has easy versions like `.onTapGesture`

```swift
var theGesture: some Gesture {
  return TapGesture(count: 2)
  	.onEnded { /* Do something */ }
}
```

### Non- Discrete Gestures

* Handle the Gesture **while it is happening** (ie. `DragGesture`, `RotationGesture`)
  * Long Press Gestures can be both Discrete & Non-Discrete
* Has a `value` that represents the **state of the Gesture when it ends**
  * `DragGesture` - start & end location of fingers
  * `MagnificationGesture` - scale of magnification
  * `RotationGesture ` - Angle of Rotation

```swift
var theGesture: some Gesture {
  return TapGesture(count: 2)
  	.onEnded { value in /* Do something */ }
}
```

* Also can find state as it is happening
  * State is stored in `@GesturedState` 
  * Uses `.updating()`
    * `value` is the same as in `.onEnded`
    * `myGestureState` is the writtable `@GestureState`
    * `transaction` has to do with animation
  * Also can use `.onChanged` - quite limited

```swift
// var always returns to <starting value> when gesture ends
@GestureState var myGestureState: MyGestureStateType = <starting value>

var theGesture: some Gesture {
  DragGesture(...)
  	.updating($myGestureState) { value, myGestureState, transaction in
    		myGestureState = /* usually something related to value */        
    }
  	.onEnded { value in /* Do something */ }
}
```



## Demo
### Storage & JSON

* When using `Codable` protocol, all members must be codable
* Use `didSet { }` as a property Observer to **watch for changes** and enact something

```swift
// To Encode
var json: Data? {
	return try? JSONEncoder().encode(self)
}

// To Decode
init?(json: Data?) {
  // if there is JSON, we get a newEmojiArt
  if json != nil, let newEmojiArt = try? JSONDecoder().decode(EmojiArt.self, from: json!){
      self = newEmojiArt
  } else {
      return nil
  }
}
```

* Takes time for json to save in UserDefaults

### Gestures

* `.clipped()` - clips image to the boundary of the View
* *Opt-Move* - pinch in the simulator
* Structs need to be `Hashable` to be put into a Set