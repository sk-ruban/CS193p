# Enumerations
* Defines a common type for a group of values
* **rawValue** is provided

### Enum Syntax

*  enum names start with **Capital Letters**
```swift
enum CompassPoint { 
	case north, south, east, west
} 

var directionToHead = CompassPoint.west
directionToHead = .south  //infered from prior
```

### Matching with Switch Statements
* Cases must be exhaustive (ie. all cases) -> can provide default
```swift
switch directionToHead {
case .north:
    print("Lots of planets have a north")
case .south:
    print("Watch out for penguins")
case .east:
    print("Where the sun rises")
case .west:
    print("Where the skies are blue")
}
// Prints "Watch out for penguins"
```

### Iterations
*  use **.allCases** to access the enum
```swift
enum Beverage: CaseIterable {
    case coffee, tea, juice
}
for beverage in Beverage.allCases {
    print(beverage)
}
```

### Associated Values
* Declare different types for cases
```swift
enum Barcode { 
	case upc(Int, Int, Int, Int) 
	case qrCode(String) 
} 
var productBarcode = Barcode.upc(8, 85909, 51226, 3)
productBarcode = .qrCode("ABCDEFGHIJKLMNOP")

switch productBarcode {
case .upc(let numSys, let manufac, let product, let check):
    print("UPC: \(numSys), \(manufac), \(product), \(check).")
case let .qrCode(productCode): 	//bring the let out
    print("QR code: \(productCode).")
}
// Prints "QR code: ABCDEFGHIJKLMNOP."
```

### Raw Values
* For **Int**, values set **from 0**, need to declare if want differently
* For **String**, value is **case name**
* Use **.rawValue** to get raw value
```swift
enum Planet: Int { 
	case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune 
} 
let possiblePlanet = Planet(rawValue: 7) // It is of optional type

enum CompassPoint: String {
    case north, south, east, west
}
let direction = CompassPoint.north.rawValue // "North"
```

### Recursive enums

* enum that has another instance of the same enum as the associated value
* Indicate it's recursive using **indirect**

```swift
enum ArithmeticExp {
  	// Plain number
    case number(Int)
  	// Addition 
    indirect case addition(ArithmeticExp, ArithmeticExp)
  	// Multiplication
    indirect case multiplication(ArithmeticExp, ArithmeticExp)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
```

