# Protocols
* Protocol is a blueprint of requirements that the adoptee MUST implement / conform



## Protocol Syntax

```swift
protocol SomeProtocol { 
  	// protocol definition goes here 
}

struct SomeStructure: SomeProtocol, AnotherProtocol {
    // structure definition goes here
}
```



## Property Requirements

* Only specifies the required **property name** & **type**
* Only specifies whether its **gettable** or **settable**

```swift
protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")
// john.fullName is "John Appleseed"
```



## Mutating Method Requirements
* to **modify** struct and enum **instances**, conforming to protocols, use `mutating`
```swift
protocol Togglable {
    mutating func toggle()
} 

enum OnOffSwitch: Togglable {
    case off, on
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}
var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()
// lightSwitch is now equal to .on
```



## Initializer Requirements

* `required` to implement inherited init requirements for all subclasses

```swift
protocol SomeProtocol {
    init(someParameter: Int)
}

class SomeClass: SomeProtocol {
    required init(someParameter: Int) { 
      // initializer implementation goes here 
    }
}
```

* `required override` for subclass to override superclass



## Protocol as Types

* Can use protocols as fully fledged types (existential types)
* Can also store in a collection as in Arrays / Dicts
```swift
protocol RandomNumberGenerator {
    func random() -> Double
}

class Dice {
    let sides: Int
    let generator: RandomNumberGenerator // Of Type RandomNumberGenerator
    init(sides: Int, generator: RandomNumberGenerator){
      //...
    }
}

let things: [TextRepresentable] = [game, d12, simonTheHamster]
```



## Delegation

* Enables a class / structure to hand off (or _delegate_) some of its responsibilities to an instance of another type.
* Mark delegates as `weak var`



## Protocols for Extensions

* Allow **exisiting type** to **conform to a new protocol** using an extension

```swift
protocol TextRepresentable {
    var textualDescription: String { get }
}

extension Dice: TextRepresentable {
    var textualDescription: String {
        return "A \(sides)-sided dice"
    }
}
```

### Conditional Conformance
* To satisfy the requirements of a protocol only **under certain conditions**
* Use `where` clause
```swift
// Array instance only conforms when Element does
extension Array: TextRepresentable where Element: TextRepresentable { 
	...
} 
```



## Synthesized Implementation

*  **Equatable** -  equate 2 struct instances
* **Comparable** - compare between struct instances
* **Hashable** - ???



## Protocol Inheritance

* Protocols can inherit from one another

```swift
protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
    // protocol definition goes here
}
```



## Class-Only Protocols

* To limit protocol adoption to **only class types**; use `AnyObject`
```swift
protocol SomeClassOnlyProtocol: AnyObject {
    // class-only protocol definition goes here
}
```



## Protocol Composition 

* Combine multiple protocols into a single protocol composition requirement

```swift
protocol Named {
    var name: String { get }
}
protocol Aged {
    var age: Int { get }
}
struct Person: Named, Aged {
    var name: String
    var age: Int
}
func wishHappyBirthday(to celebrator: Named & Aged) { 
  	// celebrator must conform to Name & Aged
    print("Happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}
let birthdayPerson = Person(name: "Malcolm", age: 21)
wishHappyBirthday(to: birthdayPerson)
// Prints "Happy birthday, Malcolm, you're 21!"
```



## Checking for Protocol Conformance

* Use `as` and `is` to check for protocol confromance

```swift
protocol HasArea {
    var area: Double { get }
}

for object in objects {
  	// checks whether object confroms to HasArea Protocol
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
    } else {
        print("Something that doesn't have an area")
    }
}
```



## Optional Protocol Requirements

* For optional requirements, use `optional` prefix

```swift
// Object C Protocol
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int // Optional
    @objc optional var fixedIncrement: Int { get }
}

```



## Protocol Extensions

* Extend a protocol to provide new methods, inits etc.

```swift
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}
```
