# Deinitialization
* Called **immediately before** a class instance is **deallocated**
* Use `deinit`

## How Deinits Work
* Swift auto deallocates instances when not needed
* For example, you might need to close a file before class instance is deallocated

## Deinits in Action
```swift
class Bank {
    static var coinsInBank = 10_000
    static func distribute(coins numberOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numberOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    static func receive(coins: Int) { coinsInBank += coins }
}

class Player {
    var coinsInPurse: Int
    init(coins: Int) { coinsInPurse = Bank.distribute(coins: coins) }
    deinit { Bank.receive(coins: coinsInPurse) }
    // Runs just before player deallocated
}

var playerOne: Player? = Player(coins: 100)
print("A new player has joined the game with \(playerOne!.coinsInPurse) coins")
// Prints "A new player has joined the game with 100 coins"
print("There are now \(Bank.coinsInBank) coins left in the bank")
// Prints "There are now 9900 coins left in the bank"

playerOne = nil
print("PlayerOne has left the game")
// Prints "PlayerOne has left the game"
print("The bank now has \(Bank.coinsInBank) coins")
// Prints "The bank now has 10000 coins"
```