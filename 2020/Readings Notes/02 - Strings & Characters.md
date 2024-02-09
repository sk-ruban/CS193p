# Strings & Characters

* Strings are **value type** (Uniquely copied when passed into funcs or methods)
  * Class is reference type (Relys on Pointers)
* **.count** - count characters
* .hasSuffix & .hasPrefix - checks whether String ends/starts with another String



## String Literals

### Multi Line Strings

```swift
let quotation = """
The White Rabbit put on his spectacles.  "Where shall I begin,
\ -> remove line breaks
please your Majesty?" he asked.

"Begin at the beginning," the King said gravely, "and go on
till you come to the end; then stop."
"""
```

### Unicode / Emoji
```swift
let sparklingHeart = "\u{1F496}" // 💖, Unicode scalar U+1F496
```

### Initialising 

```swift
var emptyString = ""               // empty string literal
var anotherEmptyString = String()
```



## Characters

* Is a **type** 
* Can append to String but cannot be appended (Must be singular)
```swift
let catCharacters: [Character] = ["C", "a", "t", "!", "🐱"] 
let catString = String(catCharacters) 
print(catString) 
```



## String Interpolation

```swift
#"\(…)”#  // Removes the string interpolation
```



## Unicode

### Graphemes

* é = u{E9} = u{65}u{301} = e + ‘



## String Indices

* **String.Index** corresponds to position of each Character
* **startIndex**: First Character
* **endIndex**: ( Last Character + 1 ) -> just `endIndex` is not valid, used to place things

```swift
var welcome = "hello" 
let index = welcome.index(welcome.startIndex, offsetBy: 3) 
welcome[index] 

welcome.insert("!", at: welcome.endIndex) 
welcome.remove(at: welcome.index(before: welcome.endIndex))
```



## Substring

* If you use a method on a string, you get a **substring** ->  reuses memory of original string
* Can only use for a short amount of time, so convert to a String