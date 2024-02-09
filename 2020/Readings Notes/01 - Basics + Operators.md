## The Basics
### Types
* Int can store values from +-2,147,483,648
* Double is 64 Bit, Float is 32 Bit
* Swift chooses Double over Float during type inference
* Floats rounded down when converted to Int
* Type alias - nickname for types
```swift
typealias AudioSample = UInt16
```

### Numeric Literals

* A _binary_ number, with a 0b prefix (0b10001 = 17)
* An _octal_ number, with a 0o prefix (0o21)
* A _hexadecimal_ number, with a 0x prefix (0x11)

### Tuple

```swift
let http404Error = (404, "Not Found") // Can name them also
let (statusCode, statusMessage) = http404Error 
print("The status code is \(statusCode)") 
		// OR
print("The status code is \(http404Error.0)")
```

### Optionals 

``` swift
let possibleNumber = "123"
let convertedNumber = Int(possibleNumber) // Will return an Int?

```

* Use ! to unwrap Optional Type (?)
* Optional Binding - Use of if let

```swift
// If the optional contains a value ...
if let actualNumber = Int(possibleNumber) {
    ...
} else { ... }
```

### Error Handling

* Use **throws** if a function can fail

```swift
func canThrowAnError() throws { 
	// this function may or may not throw an error 
}

// later....
do { 
	try canThrowAnError() 
	// no error was thrown 
} catch { 
	// 1st error was thrown 
} catch { 
	// 2nd error was thrown 
} 
```



## Basic Operators

### Remainder Operator
```swift
9 % 4 // equals 1
```

### Ternary Conditional Operator

```swift
let contentHeight = 40 
let hasHeader = true 
let rowHeight = contentHeight + (hasHeader ? 50 : 20) 
// rowHeight is equal to 90 
```

### Nil Coalescing Operator

* a ?? b - unwraps optional 'a' if it has value, else sets as default 'b'

```swift
var colorNameToUse = userDefinedColorName ?? defaultColorName
```

### One Sided Range

```swift
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names[2...] {
    print(name)
}
// Brian
// Jack
```
