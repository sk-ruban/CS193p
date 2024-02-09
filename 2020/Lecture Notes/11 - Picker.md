# Lecture 11 - Picker

### Live Editing

* To **prevent live-editing** on sheets, save the changes as a **draft** with a "Done Button"

  ```swift
  @State private var draft: FlightSearch
  
  var done: some View {
      Button("Done") {
          // draft struct get copied over
          self.flightSearch = self.draft
          self.isPresented = false
      }
  }
  ```

### Picker

* Picker( **Label**, **$Selection** - what we want to change, **Choices**)

* `.tag()` allows to put the choice (airport) into the $Selection (draft.destination) of a same type

* Pickers look better in `Form` + `NavigationView`

  ```swift
  Picker("Destination", selection: $draft.destination) {
      ForEach(allAirports.codes, id: \.self) { airport in
          // ! Binding has to be same type as Tag
          Text("\(self.allAirports[airport]?.friendlyName ?? airport)").tag(airport)
      }
  }
  ```

* `String?.none` = `nil`

### Toggle

```swift
Toggle(isOn: $draft.inTheAir) { Text("Enroute Only") }
```

