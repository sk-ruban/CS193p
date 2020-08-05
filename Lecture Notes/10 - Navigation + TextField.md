# Lecture 10 - Navigation + TextField
## Demo

### PopOvers

* `.popover` for iPads & `.sheet` for iPhones
* `.environmentObject` to pass the Object & `@EnvironmentObject` to receive

```swift
.popover(isPresented: $showPaletteEditor) {
  PaletteEditor(chosenPalette: self.$chosenPalette, isShowing: self.$showPaletteEditor)
      .environmentObject(self.document)			 // Passing an Environment Object
      .frame(minWidth: 300, minHeight: 300)  // For Size
}
```

### TextField

* 3rd Argument `onEditingChange:` to check when TextField has been edited

```swift
TextField("Palette Name", text: $paletteName, onEditingChanged: { began in
    // !began = when editing ends
    if !began {
        self.document.renamePalette(self.chosenPalette, to: self.paletteName)
    }
})
```

### Keypaths

* `private var id: KeyPath<Item,ID>` is essentially KeyPath<Root,Type>

### Navigation Links + List

* Used to link to other Views

* `.navigationBarTitle` to Title 

  ```swift
  ForEach(store.documents) { document in
      NavigationLink(destination: EmojiArtDocumentView(document: document)
          .navigationBarTitle(self.store.name(for: document))  // Bar Title of View
      ) {
          // View
        }
  ```

* To delete from a List, use `.onDelete`

  ```swift
  .onDelete { indexSet in
      indexSet.map { self.store.documents[$0] }.forEach { document in
          self.store.removeDocument(document)
      }
  }
  ```

* To allow editing, use `Editbutton()` or:

  ```swift
  @State private var editMode: EditMode = .inactive
  
  List {
    Editable(self.store.name(for: document),isEditing: self.editMode.isEditing) { name in
        self.store.setName(name, for: document)
    }
  }
  .environment(\.editMode, $editMode)
  ```

### Copy & Paste

* Cannot put 2 `.alert()` together

```swift
if let url = UIPasteboard.general./* type of thing copied (eg. url) */ {
  // do something
}
```