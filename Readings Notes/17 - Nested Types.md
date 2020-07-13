# Nested Types
* Nest supporting enumerations, classes, and structures within the definition of the type they support



## Nested Types in Action

```swift
struct BlackjackCard {
    // nested Suit enumeration
    enum Suit: Character {
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }
    // nested Rank enumeration
    enum Rank: Int {
        // ...
    }
}

let theAceOfSpades = BlackjackCard(rank: .ace, suit: .spades)
let heartsSymbol = BlackjackCard.Suit.hearts.rawValue
// heartsSymbol is "♡"
```