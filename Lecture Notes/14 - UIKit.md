# Lecture 14 - UIKit

* UIKit uses **MVC**, controlled by a controller

  * Needs both `UIViewRepresentable` & `UIViewControllerRepresentable` when using UIKit

    1. func that **creates**

       `func makeUIView{Controller}(context: Context) -> view/controller`

    2. func that **updates**

       `func updateUIView{Controller}(view/controller, context: Context)`

    3. Coordinator object that **handles delegate**

       `func makeCoordinator() -> Coordinator`

    4. **Context** (Coordinator, Environment & Animation Transactions)

       `// passed into the methods above`

    5. **Clean up** after View or Controller disappears

       `func dismantleUIView{Controller}(view/controller, coordinator: Coordinator)`

* Uses a concept called **delegation**

  * Objects have a `var delegate`



## Demo

### MapKit

* For Maps, import UIKit & MapKit
* MapView is `UIViewRepresentable`
* For Annotations, coordinator controls how the annotations are drawn

```swift
extension Airport: MKAnnotation {
    public var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    public var title: String? { name ?? icao }
    public var subtitle: String? { location }
}

struct MapView: UIViewRepresentable {
    let annotations: [MKAnnotation]
  	
  	func makeUIView(context: Context) -> MKMapView {
        // ...
        mkMapView.addAnnotations(self.annotations)
        return mkMapView
    }
  
  	class Coordinator: NSObject, MKMapViewDelegate {
    
      	// Creating annotation delegate
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            let view = mapView.dequeueReusableAnnotationView(withIdentifier: "MapViewAnnotation") ??
                MKPinAnnotationView(annotation: annotation, reuseIdentifier: "MapViewAnnotation")
            view.canShowCallout = true
            return view
        }
    }
}

MapView(annotations: airports.sorted())
```

### Photo Image Picker

* ImagePicker is `UIViewControllerRepresentable`
* Controller has to implement `NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate`
* Controller has to have functions for **picking the image and cancelling**
  * Get the image as `info[.originalImage] as? UIImage`
* `typealias` removes need for typing function arguments again and again
* Check if camera is available on device with `.isSourceTypeAvailable(.camera)`
* Info.plist to allow Camera use permissions

