# Assignment 2 

### Task 1 - 2

The code for the Memorize App including this assignment can be found at [link](https://github.com/sk-ruban/CS193p/tree/master/03%20%26%2004%20-%20Memorize)

### Task 3 - 4: New Themes

* Added 6 new themes with a new Themes.swift file

```swift
// Themes.swift
import SwiftUI

struct Theme {
    var name: String
    var emojis: [String]
    var color: Color
  	var accentColor: Color // For Extra Credit 1
    var noOfPairs: Int?
}

let themes: [Theme] = [
    Theme(					
        name: "Halloween",
        emojis: ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"],
        color: .orange,
    		accentColor: .red),				
 				// No number of pairs for first theme as per requirements
    Theme(
        name: "Flags",
        emojis: ["🇸🇬","🇯🇵","🏴‍☠️","🏳️‍🌈","🇬🇧","🇹🇼","🇺🇸","🇦🇶","🇰🇵","🇭🇰","🇲🇨","🇼🇸"],
        color: .red,
        noOfPairs: 6,
    		accentColor: .blue),
    	// So on and so forth for all 6 themes
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
      .navigationBarItems(trailing: Button("New Game"){		// Task 6
                self.viewModel.newGame() })
}
```

### Task 8: Score Tracking

* Add a new var to `Card	` to check whether the card has been flipped before & a `score` to track the score

* Thereafter, check for the 3 cases:

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

* For the app to display properly in Landscape Mode on large screen devices.

```swift
// View
NavigationView{
  		// ...
}
.navigationViewStyle(StackNavigationViewStyle())
```

### Extra Credit 1: Gradient Theme

* Add a new property for CardView called 'gradient'
* Send `theme.color` and `theme.accentColor` to CardView as a Gradient
* Use the .fill modifier to add in a Linear Gradient

```swift
// View
Grid(viewModel.cards) { card in
                    CardView(card: card, 
                             gradient: Gradient(colors: [self.viewModel.theme.color, self.viewModel.theme.accentColor]))
                       .onTapGesture { //...

struct CardView: View {
    var card: MemoryGame<String>.Card
    let gradient: Gradient  // Add new property
    // ...
  	} else {
    		if !card.isMatched{
    				RoundedRectangle(cornerRadius: cornerRadius)
               .fill(LinearGradient(gradient: gradient, startPoint: .topLeading, endPoint: .bottomTrailing)) // Linear Gradient
                }
```

### Extra Credit 2: Timed Scoring System

* Add a score multiplier to the `choose` function
* Add the following code for the Card struct

```swift
// Model

mutating func choose(card: Card){
		let scoreMultiplier = Int(max(10 - (card.faceUptime), 1))
  	// ...
  	score += 2 * scoreMultiplier
  
  
struct Card: Identifiable {
    var isFaceUp: Bool = false {
        // didSet calls after isFaceUp changes
        didSet {
            if isFaceUp { startUsingBonusTime() } 
          	else { stopUsingBonusTime() }
        }
    }
  
    //...

    var lastFaceUpDate: Date?
    var pastFaceUpTime: TimeInterval = 0

    var faceUptime: TimeInterval {
        if let lastFaceUpDate = lastFaceUpDate {
            return pastFaceUpTime + Date().timeIntervalSince(lastFaceUpDate)
        } else {
            return pastFaceUpTime
        }
    }

    // called when the card transitions to face up state
    private mutating func startUsingBonusTime() {
        if lastFaceUpDate == nil {
           lastFaceUpDate = Date()
        }
    }

    // called when the card goes back face down (or gets matched)
    private mutating func stopUsingBonusTime() {
        pastFaceUpTime = faceUptime
        lastFaceUpDate = nil
    }
}
```

