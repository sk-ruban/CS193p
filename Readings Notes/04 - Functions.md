# Functions
## Return Values

### Multiple return values

```swift
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var currentMin = array[0]
    var currentMax = array[0]
    for value in array[1..<array.count] {
        if value < currentMin {
            currentMin = value
        } else if value > currentMax {
            currentMax = value
        }
    }
    return (currentMin, currentMax)
}

let bounds = minMax(array: [8, -6, 2, 109, 3, 71])
print("min is \(bounds.min) and max is \(bounds.max)")
// Prints "min is -6 and max is 109"
```

### Optional Tuple Return
* If the return tuple type has potential to have `nil`
```swift
func minMax(array: [Int]) -> (min: Int, max: Int)? {
```

### Implicit Return
* If the body of func is a single expression, `return` not needed
```swift
func greeting(for person: String) -> String { 
		"Hello, " + person + "!" 
} 
```



## Argument Labels

### Omitting Argument Labels + Default Values

```swift
func someFunction(_ firstParameterName: Int // Omitted Label
                  , secondParameterName: Int = 12 // Default Value
                 ) {...}
someFunction(1)
```

### Variadic Parameters
* Accepts 0 or more values of a type (eg. Double…)
```swift
func arithmeticMean(_ numbers: Double...) -> Double {
    var total: Double = 0
    for number in numbers {
        total += number
    }
    return total / Double(numbers.count)
}
arithmeticMean(1, 2, 3, 4, 5)
// returns 3.0, which is the arithmetic mean of these five numbers
```

### In-Out Parameters
* Since Func parameters are **constants**, need `inout` to modify them.
* Parameter names prefixed with `&`
```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let temporaryA = a
    a = b
    b = temporaryA
}
swapTwoInts(&someInt, &anotherInt)
```



## Function Types

* `func printHelloWorld() {...}`  has type **() -> Void**
* Swift can infer types when passing into var / let

