# Subscripts
* Shortcuts to access member elements of a collection, list, sequence
	* Use `Array[0]`  to access the first element of Array

## Subscipt Syntax
```swift
struct TimesTable {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}
let threeTimesTable = TimesTable(multiplier: 3)
print("six times three is \(threeTimesTable[6])")
// Prints "six times three is 18"
```

## Type Subscript
* Subscripts that are called on the type itself
* Use `static subscript`
```swift
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    static subscript(n: Int) -> Planet {
        return Planet(rawValue: n)!
    }
}
let mars = Planet[4]
print(mars)
```