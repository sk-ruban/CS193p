# Properties
## Stored Properties

* Instance of struct with let - cannot change properties 
* Instance of class with let - can change properties (reference type)

### Lazy Stored Properties
* Initial value of property **not calculate until used**
* Useful when initial value **dependant on outside factors** until after **init complete / computational expensive tasks** (eg. loading docs)
```swift
class DataImporter {
    // Class takes a nontrivial amt of time to initialize.
    var filename = "data.txt"
}
class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}
let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")
print(manager.importer.filename) // importer property only created now
```



## Computed Properties - Get / Set

* **Don’t store values** but just **gets** to receive value from other properties
* **Sets** to set value of other properties
* Default name of **newValue** if setter doesn't define name
```swift
class Triangle {
    var sideLength = 30.0
    var newValue = 5.0
    var perimeter: Double {
        get { 3.0 * sideLength } // no need return
        set { sideLength = newValue / 3.0 } 
    }
}

let myTriangle = Triangle()
let someVar = myTriangle.perimeter // Calls the get
myTriangle.perimeter = 100 // Calls the set with newValue = 100
```
* **Read only** - getter but no setter
```swift
struct Cuboid { 
var width = 0.0, height = 0.0, depth = 0.0 
var volume: Double { width * height * depth } 
} 
```



## Property Observers

* Observe and respond to changes in property values
* Like `@State` in SwiftUI
* `willSet` - called before value stored (default name - **newValue**)
* `didSet` - called after value stored (default name - **oldValue**)
```swift
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue  {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}
let stepCounter = StepCounter()
stepCounter.totalSteps = 200
// About to set totalSteps to 200
// Added 200 steps
stepCounter.totalSteps = 360
// About to set totalSteps to 360
// Added 160 steps
```



## Property Wrapper

* Write management code once and **reuse** by applying to multiple properties
* Defines a `wrappedValue` property
```swift
// Ensures that value <13
@propertyWrapper                    
struct TwelveOrLess {
    var number: Int = 0
    var wrappedValue: Int {
        get { number }
        set { number = min(newValue, 12) }
    }
}

struct SmallRectangle {
    @TwelveOrLess var height: Int
}

var rectangle = SmallRectangle()
print(rectangle.height)
// Prints "0"

rectangle.height = 10
print(rectangle.height)
// Prints "10"

rectangle.height = 24
print(rectangle.height)
// Prints "12"
```



## Type Properties

* Properties that belong to the type (class/struct) and not the instance
* For properties that are **universal for all instances**
### Syntax

* **static** keyword: For Type Properties (All instances) -> No need to create instance
* **class** keyword: For **subclasses to override** superclass implementation
```swift
class Student {
   static let section: String = "A"  					// static constant
   static var day: String = "Monday" 					// static variable
   var name: String = "Ruban"        					// instance variable
   var rollNum: Int = 1              					// instance variable
	 class var overrideableCompTypeProp: Int { 
		return 107 } 
}

Student.day = "Sunday" // No need to create instance for static
```