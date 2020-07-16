# Lecture 4 - Grid, enum & Optionals


## Demo

### @escaping closure

* Closure is essentially the last argument which is a function
* `@escaping` closure outlives the function it was passed to

### Group

* Use `Group` when you want to create an if/else case for Views



## enum

* Like struct; is **value type**
* Can only have discrete states
* enum can **have methods** & **computed props** but no stored props
```swift
enum FastFoodMenuItem { 
		case hamburger(numberOfPatties: Int) // States can have Associated Data
		case fries(size: FryOrderSize) 
		case drink(String, ounces: Int) 
		case cookie // No Associated Data

		func isIncludedInSpecialOrder(number: Int) -> Bool { 
				switch self { 
						case .hamburger(let pattyCount): return pattyCount == number
				} 
      
		var calories: Int { 
      // switch on self and calculate caloric value here 
    }
}

// Setting the value of enums (Provide associated data)
let menuItem = FastFoodMenuItem.hamburger(patties: 2)
```

### Check an enum’s state 

* Use a switch statement
* Must handle all cases, else use `default`
* To use Associated Data, prefix with `let` 
  * Variable can have a different name

```swift
switch menuItem { 
		case .hamburger: print(“burger”)  	// Don't need to type FastFoodMenuItem.hamburger
		case .fries(let size): print(“\(size) order!”) // Using Associated Data with let
		case .drink: break                	// break if you dont want to do anything
		case .cookie: print(“cookie”)		
}
```

* To iterate over all the cases of an enum, use protocol `CaseIterable` and list using `.allCases`



## Optionals

* Is just an enum which looks like below
```swift
enum Optional<T> {
		case none						// Not set
		case some(<T>)			// Is set 
}
var hello: String? = nil		// .none
var hello: String? = "hi"		// .some("hi")
```
* Can use `!` or `if let` (safer) to unwrap
```swift
if let safehello = hello {
		print(safehello)
} else {
		// do something else
}
```