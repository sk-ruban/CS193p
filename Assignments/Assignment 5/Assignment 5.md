# Assignment 5

### Task 1: Remove the "Random Number of Cards"

1. Change the `noOfPairs` Optional Type to `Int`
2. Ensure all themes have a fixed number of Pairs
3. Remove the `Random.Int()` part in the ViewModel

```swift
// Themes.swift
struct Theme: Codable {
    //...
    var noOfPairs: Int 
}

let themes: [Theme] = [
    Theme(
        // ...
        noOfPairs: 8)
]

// ViewModel
return MemoryGame<String>(numberOfPairs: theme.noOfPairs) { index in
            return emojis[index]
}
```



### Task 2: Print a JSON Representation of the Theme

1. Allow `Theme` to conform to `Codable`
2. Add the extensions given in the Assignment PDF to the extensions file 
3. Change the theme color to a Type `UIColor.RGB` as in the extension
4. Convert  `Theme` to JSON as in EmojiArt
5. Use the `.utf8` Data extension to print the JSON Data

```swift
// Themes.swift
struct Theme: Codable {
    // ...
    var colorRGB: UIColor.RGB
  
		var color: Color { Color(colorRGB) }
    var json: Data? { try? JSONEncoder().encode(self) }
}

let themes: [Theme] = [
    Theme(
       	//...
        colorRGB:  UIColor.orange.rgb)
]
  
// ViewModel
func newGame() {
  	// ...
  	print("json = \(theme.json?.utf8 ?? "nil")")
}
```

