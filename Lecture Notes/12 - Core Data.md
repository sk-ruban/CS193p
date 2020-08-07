# Lecture 12 - Core Data

* Used to store/retrieve data in a database

* Core Data does storage in SQL

* Essentially creates a map with "relationships" of type `NSSet`

  * Xcode will generate classes for the map

  * We **use extensions** to add own methods and vars to classes

  * These objects - **ObservableObjects** are the source of data

  * `@FetchRequest` like `ObservedObject` fetches the objects constantly

    ```swift
    @FetchRequest var flights: FetchedResults<Flight>
        
    init(_ flightSearch: FlightSearch) {
        let request = Flight.fetchRequest(flightSearch.predicate)
        _flights = FetchRequest(fetchRequest: request)
    }
    ```

* Adds code in `SceneDelegate`

  * First line gets a window `NSManagedObjectContext` onto the database to access objects

  * Second line passes context into the `@Environment` of SwiftUI Views

  * `.predicate` to specify what kind of date to fetch

  * `.sortDescriptors` to sort the Data

  * `.fetch` to Fetch

    ```swift
    @Environnment(\.managedObjectContext) var context
    let flight = Flight(context: context)
    
    // Adding data
    flight.aircraft = “B737” 
    let ksjc = Airport(context: context)
    ksjc.icao = “KSJC” 
    flight.origin = ksjc  // this would auto add flight to ksjc.flightsFrom too
    
    // Saving 
    try? context.save()
    
    // Fetching Data
    let request = NSFetchRequest<Flight>(entityName: “Flight”)
    // To specify what kind of data to fetch
    request.predicate = NSPredicate(format: “arrival < %@ and origin = %@“, Date(), ksjc)
    // To sort the Array - key: name you want to sort by
    request.sortDescriptors = [NSSortDescriptor(key: “ident”, ascending: true)]
    // To fetch
    let flights = try? context.fetch(request) // nil if failed, [] if no flights
    ```

    

## Demo

* In AppName.xcdatamodeld, input the respective **entities** (classes) & **attributes** (vars)

* `import CoreData`

* To convert from relationship's  `NSSet` to `Set<Flight>`:

  ```swift
  var flightsTo: Set<Flight> {
      get { (flightsTo_ as? Set<Flight>) ?? [] }
      set { flightsTo_ = newValue as NSSet }
  }
  ```

* *Context in environment is not connected to a persistant store coordinator* Error - Pass environment into the sheet / modal etc.

  ```swift
  @Environment(\.managedObjectContext) var context
  
  .sheet(isPresented: $showFilter) {
      FilterFlights(flightSearch: self.$flightSearch, isPresented: self.$showFilter)
          // Pass context into sheet
          .environment(\.managedObjectContext, self.context)
  }
  ```

  

