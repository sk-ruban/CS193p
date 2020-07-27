# Assignment 1

### Task 1

The code for the Memorize App including this assignment can be found at [link](https://github.com/sk-ruban/CS193p/tree/master/1%20%26%202%20-%20Memorize)

### Task 2: Shuffle the Cards

* `.shuffled()` modifier

```swift
// ViewModel
var cards: Array<MemoryGame<String>.Card> {
        model.cards.shuffled()
}
```



### Task 3: width:height of 2:3

* `.aspectRatio()` modifier

```swift
// View
HStack {
		ForEach(viewModel.cards) { card in
    // ...          
}
.aspectRatio(2/3, contentMode: .fit)
```



### Task 4: Random number of pairs

* `Int.random()` modifier

```swift
// ViewModel
return MemoryGame<String>(numberOfPairs: Int.random(in: 2...5)) { index in
```



### Task 5: Font Adjust

* `.font` Modifier with nil-coalescing operator

```swift
// View
HStack {
    // ...          
}
.font(viewModel.cards.count < 5 ? Font.largeTitle : Font.title)
```



### Task 6: Works in Portrait or Landscape Mode

* For the app to display properly in Landscape Mode on large screen devices (iPad Pro)
* Wrap the HStack in a `NavigationView` and add the style modifier

```swift
// View
NavigationView{
  		// ...
}
.navigationViewStyle(StackNavigationViewStyle())
```



### Extra Credit: More emojis

* Add in the extra emojis and use the `.shuffled()`modifier to ensure that not only the first few emojis are chosen every time.

```swift
// ViewModel
let emojis: Array<String> = ["👻","🎃","🕷","🧟‍♂️","🧛🏼‍♀️","☠️","👽","🦹‍♀️","🦇","🌘","⚰️","🔮"].shuffled()
```

