# Methods
* Methods are Funcs that associated with a **particular type**

## Instance Methods
* Functions that belong to instances of a particular class, structure, or enumeration
```swift
class Counter {
    var count = 0
    func increment() {count += 1} // Instance Method 1
    func increment(by amount: Int) {count += amount} // Instance Method 2
    func reset() {count = 0} // Instance Method 3
}
let counter = Counter()  // the initial counter value is 0
counter.increment()			 // the counter's value is now 1
counter.increment(by: 5) // the counter's value is now 6
```

### self Property
* Refer to an **Instance Property** from an Instance Method
* Only necessary when parameter for IM same as property name
```swift
struct Point {
    var x = 0.0, y = 0.0
    func isToTheRightOf(x: Double) -> Bool {
        return self.x > x
    }
}
let somePoint = Point(x: 4.0, y: 5.0)
if somePoint.isToTheRightOf(x: 1.0) {
    print("This point is to the right of the line where x == 1.0")
}
// Prints "This point is to the right of the line where x == 1.0"
```

### Modifying Value Types
*  **mutating** to modify Instance Properties in Value Types (Structs / enums)
```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func isToTheRightOf(x: Double) {
        self.x += x
    }
}
var somePoint = Point(x: 4.0, y: 5.0)
somePoint.isToTheRightOf(x: 6.0)
print(somePoint.x)
```

### Assigning to self Within a Mutating Method

* Just **self** refers to the entire Instance

```swift
struct Point {
    var x = 0.0, y = 0.0
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = Point(x: x + deltaX, y: y + deltaY)  // Modifies the entire instance
    }
}
```



## Type Methods

* Methods that you call on an instance of a particular type

* **static**: For properties that don't change from what was defined in class / struct
* **class**: For subclasses to override superclass implementation

