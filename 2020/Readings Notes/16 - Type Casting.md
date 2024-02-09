# Type Casting
* To check the type of an instance

  

## Defining a Class Hierarchy
* Instances of subclasses are inferred as their superclass
* To work with Native Type, need to check their type + downcast them
```swift
class MediaItem {
	  // ...
}
class Movie: MediaItem {
    // ...
}

class Song: MediaItem {
    // ...
}
let library = [
    Movie(name: "Casablanca", director: "Michael Curtiz"),
    Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
]
// the type of "library" is inferred to be [MediaItem]
// items stored in library are still Movie and Song instances behind the scenes
```



## Checking Type

* Use type check operator `is` to check instance type
		* returns `true` is of that type else `false`
```swift
for item in library {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs")
// Prints "Media library contains 2 movies and 3 songs"
```



## Downcasting

* Downcast to the subclass type with a *type cast operator* `as?` or `as!`
```swift
// Item might be Movie, Song or MediaItem
for item in library {
    if let movie = item as? Movie { 			// Optional Binding - Try to access item as Movie
        print("Movie: \(movie.name), dir. \(movie.director)")
    } else if let song = item as? Song {		// Else access as Song
        print("Song: \(song.name), by \(song.artist)")
    }
}
```



## Any & AnyObject

* `Any`  represent an instance of any type at all, including function types
* `AnyObject` can represent an instance of any class type.
```swift
var things = [Any]()

things.append(0)
things.append(0.0)
things.append("hello")
```