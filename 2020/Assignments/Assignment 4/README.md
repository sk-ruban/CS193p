# Assignment 4 

### Task 1

The code for the EmojiArt App including this Assignment can be found at [link](https://github.com/sk-ruban/CS193p/tree/master/07%20%26%2008%20-%20EmojiArt)

### Task 2-5: Selection of Emojis

1. Create an Array to store the selected emojis.
2. Create an extension to check if the emoji is already in the `selectedEmojis` Array and add it to the Array if it isn't inside, else remove it.
3. Select the emojis using a `.onTapGesture`.
4. `.shadow` modifier to display the selected emojis.
5. Use `.removeAll()` to deselect all emojis after single tapping the background image.

```swift
// 1
@State var selectedEmojis: Set<EmojiArt.Emoji> = []

// 2
// EmojiArtExtensions.swift
extension Set where Element: Identifiable {
    mutating func toggleMatching(_ emoji: Element) {
        if contains(matching: emoji) {
            let indexOfMatchingEmoji = firstIndex(matching: emoji)
            remove(at: indexOfMatchingEmoji!)
        } else {
            insert(emoji)
        }
    }
}

// 3
ForEach(self.document.emojis) { emoji in //...
	.onTapGesture {
		self.selectedEmojis.toggleMatching(emoji)
	}
  // 4
  .shadow(color: self.emojiSelected(emoji) ? .blue : .clear , radius: 10)

// Checks whether a specific emoji is selected for (4)
private func emojiSelected(_ emoji: EmojiArt.Emoji) -> Bool {
  selectedEmojis.contains(matching: emoji)
}
                               
// 5
// Background Image
Color.white.overlay( //...
)
.onTapGesture { .selectedEmojis.removeAll() }
```

### Task 6-7: Dragging Emojis

1. Create a `DragGesture()` function which moves all the emojis in the `selectedEmojis` Array wrt to the dragged emoji.
2. The document automatically pans when there is no selection.

```swift
private func dragEmojis(for emoji:EmojiArt.Emoji) -> some Gesture {
  DragGesture()
      .updating($emojiOffset) { latestDragGestureValue, emojiOffset, transaction in
          emojiOffset = latestDragGestureValue.translation / self.zoomScale
      }
      .onEnded { finalDragGestureValue in
          let distanceDragged = finalDragGestureValue.translation / self.zoomScale
          // Move whole selection
          for emoji in self.selectedEmojis {
              self.document.moveEmoji(emoji, by: distanceDragged)
      }
   }
}

ForEach(self.document.emojis) { emoji in //...
		.gesture(self.dragEmojis(for: emoji))
```

### Task 8-9: Pinching Emojis

1. Modify the `zoomGesture()` function to check if emojis are selected and re-size them if so.
2. The document automatically scales if there is no selection.

```swift
// zoomGesture()
.onEnded { finalGestureScale in
    if self.hasSelection {
        // zoom selected Emojis
        self.selectedEmojis.forEach { emoji in
            self.document.scaleEmoji(emoji, by: finalGestureScale)
        }
    } else {
        self.steadyStateZoomScale *= finalGestureScale
    }
}
```

### Task 10: Deleting Emojis

1. Add a function to remove emojis in the ViewModel.
2. Remove the Emojis using a `LongPressGesture`.

```swift
// 1
// ViewModel
func removeEmoji(_ emoji: EmojiArt.Emoji){
    if let index = emojiArt.emojis.firstIndex(matching: emoji){
        emojiArt.emojis.remove(at: index)
    }
}

// 2
// View
private func longPress(for emoji: EmojiArt.Emoji) -> some Gesture {
    LongPressGesture(minimumDuration: 1)
        .onEnded { _ in
            self.document.removeEmoji(emoji)
    }
}

ForEach(self.document.emojis) { emoji in //...
    .gesture(self.longPress(for: emoji))
```

### Extra Credit 1: Dragging unselected Emoji

1. Modify the`DragGesture()` function to check if the emoji is selected.
2. If the emoji is unselected, only move it.

```swift
private func dragEmojis(for emoji:EmojiArt.Emoji) -> some Gesture {
  // 1  
  let isEmojiPartOfSelection = self.emojiSelected(emoji)

    return DragGesture()
        .updating($emojiOffset) { latestDragGestureValue, emojiOffset, transaction in
            emojiOffset = latestDragGestureValue.translation / self.zoomScale
        }
        .onEnded { finalDragGestureValue in
            let distanceDragged = finalDragGestureValue.translation / self.zoomScale
            // if part of Selection, move whole selection
            if isEmojiPartOfSelection {
                for emoji in self.selectedEmojis {
                    self.document.moveEmoji(emoji, by: distanceDragged)
                }
            // 2
            // else just move the unselected emoji
            } else {
                self.document.moveEmoji(emoji, by: distanceDragged)
            }
        }
}
```



