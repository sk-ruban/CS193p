# Lecture 5 - ViewBuilder + Shape + ViewModifier


## @ViewBuilder
* Add to functions to **support a list of Views**
* Usually used to build conditional Views with if / else
* **Mark parameters** that return a View
```swift
// Normally would require Group
@ViewBuilder
func front(...){
		RoundedRectangle(...)
		RoundedRectangle(...)
		Text(...)
}
// Returns TupleView <RR,RR,Text>
```



## Shape

* All shapes are Views
```swift
// To create own shape
struct Pie: Shape {
  	func path(in rect: CGRect) -> Path { 
				var p = Path()
        p.move(to: center)
      	// ...
      	return p
		}
}
```
* When drawing using angle, 0deg points to the right
* For coordinates, (0,0) is in the top left, clockwise is reversed



## ViewModifier

* Modifiers calls a function - `.aspectRatio() ` calls  `.modifier(AspectModifier())`
* Apply by using the `ViewModifier` protocol
```swift
struct Cardify: ViewModifier { 
		var isFaceUp: Bool 
		func body(content: Content) -> some View { 
				ZStack { 
						if isFaceUp { 
								// Do something 
						} else { 
								// Do something	
} } }
```
* Use an extension to change the modifier’s name
```swift
extension View { 
		func cardify(isFaceUp: Bool) -> some View { 
				return self.modifier(Cardify(isFaceUp: isFaceUp)) 
}}
```



## Demo

* `private(set)` means writing is private but reading is public
* Use PreviewProvider when possible
```swift
struct EmojiMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiMemoryGame()
        game.choose(card: game.cards[0])
        return EmojiMemoryGameView(viewModel: game)
    }
}
```

* `.opacity()` - makes color more transparent