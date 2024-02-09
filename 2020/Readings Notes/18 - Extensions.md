# Extensions
* Add **new functionality** to **existing** types / structs / classes + **adapt protocols**



## Extension Syntax

```swift
extension SomeType {
    // new functionality to add to SomeType goes here
}

extension SomeType: SomeProtocol, AnotherProtocol {
    // implementation of protocol requirements goes here
}
```



## Computed Properties

```swift
// Helps to convert to metres when Double type used
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double  { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("One inch is \(oneInch) m")      	// Prints "One inch is 0.0254 m"

let threeFeet = 3.ft
print("Three feet is \(threeFeet) m")		// Prints "Three feet is 0.914399970739201 m"
```



## Initializers

* Can **add new inits** to types
* Can only add **convenience **(secondary) inits to class (ie. must refer to main init with **self.init**)

```swift
struct Size {
    var width = 0.0, height = 0.0
}
struct Point {
    var x = 0.0, y = 0.0
}
struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        // Refers to default init
        self.init(origin: Point(x: originX, y: originY), size: size)  
    }
}
```



## Methods
```swift
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self { task() } 
} }

3.repetitions { print("Hello!")}
// Hello!
// Hello!
// Hello!
```

### Mutating Instance Methods
* Inorder to modify itself
```swift
extension Int {
    mutating func square() { self = self * self }
}
var someInt = 3
someInt.square()  // someInt is now 9
```



## Subscripts

```swift
// returns the decimal digit n places right of the number
extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex { decimalBase *= 10 }
        return (self / decimalBase) % 10
    }
}
746381295[0] // returns 5
746381295[1] // returns 9
746381295[2] // returns 2
746381295[8] // returns 7
```



## Nested Types

```swift
extension Int {
    enum Kind {
        case negative, zero, positive
    }
  	var kind: Kind {
    		switch self {
    		case 0:
        		return .zero
    		case let x where x > 0:
        		return .positive
    		default:
        		return .negative
    }
	}
}

var number = 5 // Can access number.kind
```

