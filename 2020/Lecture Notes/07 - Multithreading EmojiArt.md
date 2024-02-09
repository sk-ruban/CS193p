# Lecture 7 - Multithreading EmojiArt


## Color vs UIColor

### Color
* Color-specifier -  `foregroundColor(Color.green)`
* ShapeStyle -  `.fill(Color.green)`
* View -  `Color.green`

### UIColor
* Used to **manipulate color**
* More built-in colors
* `Color(uiColor:)` to use it in the roles above



## Image vs UImage

### Image
* Serves as a View
* `Image(systemName:)` for SF Icons
  * Control size using `.imageScale()`

### UIImage
* Type for creating and manipulating images and **storing in vars**
* `Image(uiImage:)` to display it



## Multithreading

* Used to not block the UI during CPU-intensive background tasks
* Swift uses **queues** for tasks waiting to get executed
  * *Main Queue* - Anything to do with the **UI** -  `DispatchQueue.main`
  * *Background Queue* - For non UI tasks , runs parallel to Main Queue - `DispatchQueue.global`
    * `.userInteractive` - Do it **Fast**, UI depends on it (Dragging Items)
    * `.userInitiated` - Do it **now**, User just asked (Tapping)
    * `.utility` - Needs to happen but the User didn't just ask for it 
    * `.background` - Maintenance Tasks (Cleanups)
* Queues use Closures

```swift
let queue = DispatchQueue.main
queue.async { /* code */ } // Executes when the closure gets to the front of queue
queue.sync { /* code */ }  // Blocks the UI so not usually used
```

* Nest DispatchQueues within DispatchQueues to change UI
* Usually don't use `DispatchQueue.global` , use APIs like `URLSession`



## Demo

* `ForEach` requires an Array and doesn't work with Strings
  * `palette.map { String($0) }` **.map** takes each character '$0' and converts into an array of Strings
  * `\.self` - keypath
* `ScrollView(.horizontal)` - allows for scrolling of Views
* `.edgesIgnoringSafeArea([.horizontal, .bottom])` to ignore Safe edges
* **fileprivate** - Cannot modify from outside the file
* `Collection` is a protocol Array & Set implements

### Drag & Drop

* `of:` - what kind of things you want to drop
* `location` - where you want to drop it

```swift
.onDrop(of: ["public.image", "public.text"], isTargeted: nil) { providers, location in
    // Convert iPad Coords to Centre Coords
		var location = geometry.convert(location, from: .global)
		location =  CGPoint(
				x: (location.x - geometry.size.width/2 - self.panOffset.width) / self.zoomScale,
        y: (location.y - geometry.size.height/2 - self.panOffset.height) / self.zoomScale
    )
    return self.drop(providers: providers, at: location)
}

// Drop Image
private func drop(providers: [NSItemProvider], at location: CGPoint) -> Bool {
    var found = providers.loadFirstObject(ofType: URL.self) { url in
        // print("dropped \(url)")
        self.document.setBackgroundURL(url)
    }
    if !found {
        found = providers.loadObjects(ofType: String.self) { string in
            self.document.addEmoji(string, at: location, size: self.defaultEmojiSize)
        }
    }
    return found
}
```

* `first.overlay(second)` sizes second View over first

* `Group` helps when Views require if / else

```swift
private func fetchBackgroundImageData() {
        backgroundImage = nil
        if let url = self.emojiArt.backgroundURL {
            // Dispatch to Background Queue
            DispatchQueue.global(qos: .userInitiated).async {
                if let imageData = try? Data(contentsOf: url) {
                    // Execute UI changes ONLY on Main thread
                    DispatchQueue.main.async {
                        // Check whether it's image user wants to place incase of lag
                        if url == self.emojiArt.backgroundURL {
                            self.backgroundImage = UIImage(data: imageData)
                        }
                    }
                }
            }
        }
    }
```



