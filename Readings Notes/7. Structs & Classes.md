# Structs and classes
* Classes, additional capabilities that Structs don't have:
	1. **Inheritance** for one Class to inherit from another
	2. **Type Casting** to check and intepret type of Class instance @ runtime
	3. **Deinit** to free up resources
	4. Allows **more than one reference** to a Class instance



## Syntax 

* Classes / Structs - UpperCamel case
* roperties / methods - lowerCamelCase
```swift
struct Resolution { 
	var width = 0 
	var height = 0 
} 

class VideoMode { 
	var resolution = Resolution() 
	var name: String?  // Optionals given default value: nil
}

// Create instances
let someResolution = Resolution() 
let someVideoMode = VideoMode() 

// Access Properties
var lol = someResolution.width
someVideoMode.resolution.width = 1280

// Memberwise Inits
let vga = Resolution(width: 640, height: 480)
```



## Types

### Value Types

* Structs/enums make **seperate instances** whenever **initialised** or **copied**

### Reference Types
* Classes **point** to the same instance

### Identity Operators
* === - **Identical to**: check if 2 vars/consts refer to the same class instance
* == - **Equal**: 2 instances are equal

