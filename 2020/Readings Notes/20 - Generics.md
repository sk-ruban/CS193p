# Generics
* Enables you to write flexible, reusable functions and types **that can work with any type**, subject to your defined requirements



## Generic Functions

* Placeholder type: `T`  -  **Type Parameter**
```swift
func swapTwoInts(_ a: inout Int, _ b: inout Int){ ..  // Normal
func swapTwoValues<T>(_ a: inout T, _ b: inout T){ .. // Generic
```

* Key & Value in `Dictionary<Key, Value>` are Type Parameters

  

## Generic Types

* Custom classes, structures, and enumerations that works with **any type**. Like Array & Dict
```swift
// Stack (Like Array but only allows push and pop from end of stack)
struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {  // Mutating as modifies items
        items.append(item)
    }
    mutating func pop() -> Element {
        return items.removeLast()
    }
}
var stackOfStrings = Stack<String>()
stackOfStrings.push("uno")
```



## Extending Generic Types

* Use the type parameter as in the class / struct

```swift
extension Stack {
  	// returns the Top Item in the Stack
    var topItem: Element? { return items.isEmpty ? nil : items[items.count - 1] }
}
```



## Type Constraints

* Type constraints specify that a type parameter must inherit from a **specific class**, or conform to a **particular protocol** 
* Example: Dictionary Keys must be Hashable
```swift
// T subClass of SomeClass, U conforms to SomeProtocol
func someFunction<T: SomeClass, U: SomeProtocol>(someT: T, someU: U) {
    // function body goes here
}

// Need to use Equatable since not every type can use ==
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}
```



## Associated Types

* An _associated type_ gives a **placeholder name** to a type that is used as part of the protocol but **isn't specified until the protocol is adopted**.
```swift
protocol Container {
    associatedtype Item: Equatable // AT with Constraints
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

struct IntStack: Container {
    var items = [Int]()
	  typealias Item = Int // Turns abstract Item to Int
	  // ...
}
```



## Generic Where Clauses

* Require that an  AT / Extension / Method conforms to a certain protocol / Type
```swift
// For Extensions
extension Stack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        guard let topItem = items.last else {
            return false
        }
        return topItem == item
    }
}

// For Methods
func average() -> Double where Item == Int {  // Can use == rather than :
... }

// For AT
protocol Container {
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

// For Protocols
protocol ComparableContainer: Container where Item: Comparable { ...
 }

// For Subscripts
extension Container {
  			// Conforms to Sequence protocol
    subscript<Indices: Sequence>(indices: Indices) -> [Item] 
				// indices of type Indices
        where Indices.Iterator.Element == Int {
				// Elements must be Int type
            var result = [Item]()
            for index in indices {
                result.append(self[index])
            }
            return result
    }
}
```