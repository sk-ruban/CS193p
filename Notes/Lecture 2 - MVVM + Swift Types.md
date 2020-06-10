# Lecture 2 - MVVM + Swift Type
#notes/self-learning/cs193p

## MVVM
MVVM : Model + View + ViewModel

**Model**: Data + Logic

**View**: What you see (observes publications)
	- @ObservedObject
	- @Binding
	- @EnvironementObject
	- .onreceive
    
**ViewModel**: Publishes changes
	- ObservableObject
	- @Published
	- .environementObject()
	- objectWillChange.send()

![](Lecture%202%20-%20MVVM%20+%20Swift%20Types/Screenshot%202020-06-11%20at%205.57.37%20AM.png)
View : Reflects the model (Stateless, reactive & declared)
View Model: Interpretor of Model (class - because u wanna share)

## Types
### Struct & Class
**Similarities**: stored, compted var, lets, funcs, inits
**Differences**:
![](Lecture%202%20-%20MVVM%20+%20Swift%20Types/Screenshot%202020-06-11%20at%206.06.30%20AM.png)

**Structs**
	* copied when passed, init initalises all vars, mutability must be stated
**Classes**
	* passed by pointers,  init initialises no vars, always mutable
	* ::Always used for ViewModel::

### Generics
When you dont care about a type (type agnostic) - Eg. data inside Arrays
```
struct Array<Element> {
	…
	func append(_ element: Element) { . . . }
}
var a = Array<Int>()
a.append(5)
```

Can have multiple dont care type parameters  Eg. <Element, Foo>

### Functions
Are types too!
```
var foo: (Double) -> Void
```
 foo’s type: “function that takes a Double, returns nothing”

## Demo 
Opt-click for documentation
Empty Array:
```
cards = Array<Card>()
```

### House Analogy
Views - living inside house, ViewModel - door, Model - outside world
problem of rogue view manipulating model
private var 	- model can only be accessed by the class (closes the door)
private(set) 	- class can modify the model but View can still see model
Intents 		- funcs that allow Views to access model (intercom buttons)

### Static Functions
```
class AppUtils {
    static func appUtility() {
    }
}
```
Dont need instance. Access static func as `AppUtils.appUtility()`

### Class Functions
Like static functions but can be overwritten by subclasses.

### Closures
```
private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairs: 2, cardContentFactory: { (pairIndex: Int) -> String in
        return “😋”
    })
```
can become:
```
private var model: MemoryGame<String> = MemoryGame<String>(numberOfPairs: 2) { _ in “😋” }
```

