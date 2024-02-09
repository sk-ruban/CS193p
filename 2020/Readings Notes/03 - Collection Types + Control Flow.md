# Collection Types
* **Arrays** - Ordered Collection
* **Sets** - Unordered Collection of **unique** values
* **Dictionaries** - key value pairs



## Arrays

* `Array<Element>`  or  `[Element]`
* To init array  `var someInts = [Int]()`

```swift
var threeDoubles = Array(repeating: 0.0, count: 3)
var sixDoubles = threeDoubles + ThreeDoubles
```

```swift
shoppingList.insert(“Maple Syrup”, at: 0)
shoppingList.remove(at: 0)
shoppingList.removeLast()
```

### Iteration

* To get the index value, use **.enumerated()**
```swift
for (index, value) in shoppingList.enumerated() { 
	print(“Item \(index + 1): \(value)”) 
} 
```



## Sets

* Use instead of Array when **order of items not important** or **item only appears once**
* Type must be **hashable** to be stored in Set
* `Set<Element>`
```swift
// To init Sets
var letters = Set<Character>() // Empty Set
// OR
var favoriteGenres: Set<String> = ["Rock", "Classical", "Hip hop"]
```

```swift
favoriteGenres.insert("Jazz") // Insert
removedGenre = favoriteGenres.remove("Rock") // returns "Rock" + removes
favoriteGenres.contains("Funk")  // returns Boolean (false)
```

![Sets](./Notes.assets/sets.png)

```swift
houseAnimals.isSubset(of: farmAnimals)   // returns Booleans
farmAnimals.isSuperset(of: houseAnimals) 
farmAnimals.isDisjoint(with: cityAnimals) 
```



## Dictionaries

* The order you insert items into Dict isn't the order they are iterated.
```swift
var namesOfIntegers = [Int: String]()
				OR
var airports: [String: String] = ["YYZ": "Toronto Pearson", "DUB": "Dublin"]
airports["LHR"] = "London"
```

- Assign nil to remove from dictionary

```swift
airports[“APL”] = nil 
// APL has now been removed from the dictionary 
```

### Iteration

```swift
for (airportCode, airportName) in airports { }
for airportCode in airports.keys { }
for airportName in airports.values { }
```

###  Conversion to Arrays

```swift
let airportCodes = [String](airports.keys)
```



# Control Flow

## For Loops
* stride(from:to:by:) to skip unwanted marks
* stride(from:through:by:) to include the end
```swift
let minuteInterval = 5
for tickMark in stride(from: 0, to: minutes, by: minuteInterval) {
    // render every 5 minutes) }
```



## While Loops

```swift
// Same as for loops
repeat { 
	statements 
} while condition 
```



## Switch

* Alternative to if statements
* No Fallthrough - finishes execution after matching first case
* To match 2 cases, combine using a ','
```swift
let someCharacter: Character = "z"
switch someCharacter {												// Some Value
case "a", "A":																// Value 1 (combined)
    print("The first letter of the alphabet")
case "z", "Z":																// Value 2 (combined)
    print("The last letter of the alphabet")
default:																			// Otherwisw
    print("Some other character") 
}
```

### Tuples

```swift
let somePoint = (1, 1) 
switch somePoint { 
case (0, 0): 
		print("\(somePoint) is at the origin") 
case (_, 0): 
		print("\(somePoint) is on the x-axis") 
case (0, _): 
		print("\(somePoint) is on the y-axis") 
case (-2...2, -2...2): 
		print("\(somePoint) is inside the box") 
default: 
		print("\(somePoint) is outside of the box") 
} 
```

### Value Bindings

* Temporary names using let, to use in the body of a case

```swift
let anotherPoint = (2, 0) 
switch anotherPoint { 
case (let x, 0): 
		print("on the x-axis with an x value of \(x)") 
case (0, let y): 
		print("on the y-axis with a y value of \(y)") 
case let (x, y): 
		print("somewhere else at (\(x), \(y))") 
} 
// Default case not need as last case handles all possibilites
```

### Where Clause

```swift
let yetAnotherPoint = (1, -1) 
switch yetAnotherPoint { 
case let (x, y) where x == y: 
		print("(\(x), \(y)) is on the line x == y") 
case let (x, y) where x == -y: 
		print("(\(x), \(y)) is on the line x == -y") 
case let (x, y): 
		print("(\(x), \(y)) is just some arbitrary point") 
} 
```



## Control Transfer Statements

### Continue

* Done with the current iteration and starts next loop

### Break
* Ends the loop execution immediately

### Fallthrough

* Causes code execution to move directly to the statements inside the next case **without checking**

```swift
let integerToDescribe = 5 
var description = "The number \(integerToDescribe) is" 
switch integerToDescribe { 
case 2, 3, 5, 7, 11, 13, 17, 19: 
		description += " a prime number, and also" 
		fallthrough 
default: 
		description += " an integer." 
} 
```

### Labeled statements
* Used if there are multiple loops and you want to break / continue a specific one
```swift
gameLoop: while square != finalSquare {
    switch square + diceRoll {
    case finalSquare:
        break gameLoop
    case let newSquare where newSquare > finalSquare:
        continue gameLoop
```

### Guard
* Requires that a condition be true to execute
* Unlike an if, guard always has an else clause
```swift
guard let name = person["name"] else { 
		return 
} 
```



## Checking API Availability

* Use **#available** to check whether API can be used on target

```swift
if #available(iOS 10, macOS 10.12, *) {
    // Use iOS 10 APIs on iOS, and use macOS 10.12 APIs on macOS
} else {
    // Fall back to earlier iOS and macOS APIs
}
```

