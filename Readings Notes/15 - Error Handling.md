# Error Handling
* Process of responding to error conditions
* Distinguishes between different situations



## Representing & Throwing Errors

* enum to list the possible error conditions
* `throw` to throw a possible error
```swift
enum VendingMachineError: Error {
    case invalidSelection
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}
throw VendingMachineError.insufficientFunds(coinsNeeded: 5)
```



## Handling Errors

### Propagating Errors Using Throwing Functions
* mark functions, methods with `throw`
* use `try` to run a function **if it can throw an error**
```swift
func vend(itemNamed name: String) throws {
		guard let item = inventory[name] else { throw VendingMachineError.invalidSelection }
		guard item.count > 0 else { throw VendingMachineError.outOfStock }
}

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    	let snackName = "Candy Bar"
    	try vendingMachine.vend(itemNamed: snackName)
}
```

### Do-Catch
* Error thrown by code in `do` clause and matched against `catch` clause
* use `try` to run a function **if it can throw an error**
```swift
var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8
do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid Selection.")
} catch VendingMachineError.outOfStock {
    print("Out of Stock.")
} catch VendingMachineError.insufficientFunds(let coinsNeeded) {
    print("Insufficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error: \(error).")
}
// Prints "Insufficient funds. Please insert an additional 2 coins."
```

### Converting to Optional Values
* Use `try?` ; if error - expression is  `nil`
```swift
func fetchData() -> Data? {
    if let data = try? fetchDataFromDisk() { return data }
    if let data = try? fetchDataFromServer() { return data }
    return nil
}
```

### Disabling Error Propagation
	* If there will be no errors, use `try!` to disable error propagation
	* If there is an error thrown -> Run Time error
```swift
let photo = try! loadImage(atPath: "./Resources/John Appleseed.jpg")
```



## Specifying Cleanup Actions

* Use `defer` to execute code just before execution leaves the current block of code
* Useful for cleanup actions
```swift
func processFile(filename: String) throws {
    if exists(filename) {
        let file = open(filename)
        defer { close(file) }
        while let line = try file.readline() {
            // Work with the file.
        }
        // close(file) is called here, at the end of the scope.
    }
}
```