# Assignment 2 

### Task 3 - 4: New Themes

Added 6 new themes with a new Themes.swift file

```swift
// Themes.swift
import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
    var noOfPairs: Int?
}

let themes: [Theme] = [
    Theme(					
        name: "Halloween",
        emojis: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
        color: .orange),				
 				// No number of pairs for first theme
    Theme(
        name: "Flags",
        emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"],
        color: .red,
        noOfPairs: 6),
    //...
]

```

### Task 5: Passing in the Theme

```swift
// ViewModel
var theme = themes.randomElement()!
static func createMemoryGame(theme: Theme) -> MemoryGame<String> {
        let emojis: Array<String> = theme.emojis.shuffled()
  			// returns the number of  cards to show (which, for one, should be random)
        return MemoryGame<String>(numberOfPairs: theme.noOfPairs ?? Int.random(in: 4...6)) { index in
            return emojis[index]
        }
    }

init(){
        model =  EmojiMemoryGame.createMemoryGame(theme: theme)
    }
```

### Task 6 - 7: NewGame + Bar Title

```swift
// View Model
func newGame() {
        theme = themes.randomElement()!
        model =  EmojiMemoryGame.createMemoryGame(theme: theme)
    }

// View
NavigationView{
			VStack {
           // ...
      }
  		.navigationBarTitle(viewModel.theme.name) 					// Task 7
      .navigationBarItems(trailing: Button("New Game"){		// Task 8
                self.viewModel.newGame() })
}
```

### Task 8: Score Tracking

Add a new var to `Card	` to check whether the card has been flipped before & a `score` to track the score

Thereafter, check for the 3 cases:

1. **Both cards match** - Add 2 points
2. **Mismatch** - Deduct 1 Point
3. **Only 1 card face up** - Nothing

```swift
// Model
var score = 0

struct Card: Identifiable {
        var isFaceUp: Bool = false
        var isMatched: Bool = false
        var content: CardContent
        var id: Int
        var hasBeenFlipped: Int = 0  // Added
    }

mutating func choose(card: Card){
        print("Card Chosen: \(card)")
        if let chosenIndex: Int = cards.firstIndex(matching: card), !cards[chosenIndex].isFaceUp, !cards[chosenIndex].isMatched {
            if let potentialMatchIndex = indexOfTheOneAndOnlyFaceUpCard {
                cards[chosenIndex].hasBeenFlipped += 1
                cards[potentialMatchIndex].hasBeenFlipped += 1
                if cards[chosenIndex].content == cards[potentialMatchIndex].content {
                     // Match Case
                    cards[chosenIndex].isMatched = true
                    cards[potentialMatchIndex].isMatched = true
                    score += 2
                } else if cards[chosenIndex].hasBeenFlipped > 1 || cards[potentialMatchIndex].hasBeenFlipped > 1{
                    // Mismatch Case
                    score -= 1
                }
                self.cards[chosenIndex].isFaceUp = true
            } else {
                // 1 Face up Card
                indexOfTheOneAndOnlyFaceUpCard = chosenIndex
            }
        }
    }
```

### Task 9: Displaying Score

```swift
// View
Text("Score: \(viewModel.score)")
```

### Task 10: Orientations

For the app to display properly in Landscape Mode on large screen devices.

```swift
// View
NavigationView{
  		// ...
    }
    .navigationViewStyle(StackNavigationViewStyle())
```
