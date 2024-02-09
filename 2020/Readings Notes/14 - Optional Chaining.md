# Optional Chaining
* Process for querying and **calling** properties, methods, and subscripts on an optional that **might be nil**
* Succeeds else returns `nil`
* Optional Chaining **fails gracefully** compared to force unwrapping
  * Force unwrapping **triggers runtime error**
  * In OC, property that normally returns an `Int` will return an `Int? `



## Accessing Properties 

* If Property has ?, must define it before accessing

```swift
class Address {
    var buildingNumber: String?
}

let someAddress = Address()
someAddress.buildingNumber = "29"
```



## Accessing Subscripts

```swift
var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91  // Checks whether subscript exists
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72 // Doesn't work
```



## Multiple Level of Chaining

*  Fails at weakest point
*  If the type you are trying to retrieve is not optional, it will become optional because of OC

```swift
if let johnsStreet = john.residence?.address?.street {
    print("John's street name is \(johnsStreet).")
} else {
    print("Unable to retrieve the address.")
}
// Prints "Unable to retrieve the address."
```

