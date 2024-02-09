# Closures
* Closures can **capture and store references** to any constants and variables from the **context in which they are defined**
* Global & nested funcs are special case closures
* **Reference** Type



## Closure Syntax

```swift
// Parameters can't have a default value
{ (parameters) -> return_type in 
		statements  
} 
```

```swift
// As a function
func backward(_ s1: String, _ s2: String) -> Bool { 
		return s1 > s2 
} 
var reversedNames = names.sorted(by: backward) 

// As a closure
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in
    return s1 > s2
})
```

### Inferring + Shortening
* Types, -> , () can be omitted
* return also can be omitted if single expression
```swift
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )
```

* names & in can be omitted
```swift
// Shorthand Argument 
reversedNames = names.sorted(by: { $0 > $1 } )

// Operator Method
reversedNames = names.sorted(by: >)
```



## Trailling Closures

* When a closure expression is the function's final argument & long

```swift
// As a Function:
func someFunctionThatTakesAClosure(closure: () -> Void) {
    // function body goes here
}

// As a Closure:
someFunctionThatTakesAClosure(closure: {
    // closure's body goes here
})

// As Trailing Closure:
someFunctionThatTakesAClosure() {
    // trailing closure's body goes here
}
```

* If the closure expression is the only argument, () not needed.

  

## Capturing Values
* Closures can capture lets and vars from surrounding context and modify them.
```swift
// Return type is () ->  Int so its returning a func
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}
let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen() 
// returns a value of 10 
incrementByTen() 
// returns a value of 20 
```



## Escaping Closures

* A closure is said to _escape_ a function when the closure is passed as an argument to the function, but is **called after the function returns**
* Use `@escaping` before the parameter type
* Used for Asyn ops where you need to call the closure only after ops is complete



## Autoclosures

* Doesn't take any arguments & returns the value of the expression inside