# Inheritance
* Class can inherit propertiers, methods etc. from another class
* **Subclass** - inheriting class 
* **Superclass** - class it inherits from
* **Base Class** - class that doesnt inherit from another



## Subclassing

```swift
// Superclass
class Vehicle {
	  var currentSpeed = 0.0
    var description: String { "traveling at \(currentSpeed) miles per hour" }
    func makeNoise() { } // Do nothing
}

// Subclass 1
class Bicycle: Vehicle {
    var hasBasket = false
}
// Bicycle is subclass of Vehicle

//Subclass 2
class Tandem: Bicycle {
    var currentNumberOfPassengers = 0
}
```

### Accessing Superclass Properties
* Use prefix **super** - ie. `super.someMethod()` or `super.someProperty`



## Overriding functions

* Use  `override` to override superclass defintions
```swift
class Train: Vehicle {
    override func makeNoise() { print("Choo Choo") }
}
```



## Overriding Property Getters & Setters

```swift
class Car: Vehicle {
    var gear = 1
    override var description: String { super.description + " in gear \(gear)" }
}
```



## Overriding Property Observers

```swift
class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet { gear = Int(currentSpeed / 10.0) + 1 }
    }
}
```



## Preventing Overrides

* Mark properties as **final**