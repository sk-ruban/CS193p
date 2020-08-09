# Lecture 13 - Persistance

* **UserDefaults** - Simple, Limited & Small
* **CoreData** - Powerful, Object Oriented
* **CloudKit** - Storing into iCloud
  * Has its own *UserDefaults thing*
  * Works with Core Data
* **FileManager** - Storing in a Unix File System



## Cloud Kit

* Simple & asynchronous but slow
* Important Components:
  * `Record Type` - like class or struct
  * `Fields` - vars
  * `Record` - instance of Record Type
  * `Database` - where Records are stored
  * `Reference` - pointer to another record
  * `Query` - a database search
* Enable iCloud under Capabilities in Project Settings

```swift
let db = CKContainer.default.public/shared/privateCloudDatabase

let tweet = CKRecord(“Tweet”)
tweet[“text”] = “140 characters of pure joy”

let tweeter = CKRecord(“TwitterUser”)
tweet[“tweeter”] = CKReference(record: tweeter, action: .deleteSelf)

db.save(tweet) { (savedRecord: CKRecord?, error: NSError?) -> Void in    
    if error == nil {
      // Hooray!    
    } else if error?.errorCode == CKErrorCode.NotAuthenticated.rawValue {
      // tell user he or she has to be logged in to iCloud for this to work!
    } else {
      // report other errors (there are 29 different CKErrorCodes!)    
    } 
}
```

* Use `NSPredicate` to query for records in Database



## File System

* There are **file protections** in Unix systems so you can only write in the applications *"sandbox"*
* Use `FileManager` to get a path to sandbox directories:

```swift
let url: URL = FileManager.default.url(    
  for directory: FileManager.SearchPathDirectory.documentDirectory, // for example    
  in domainMask: .userDomainMask  // always .userDomainMask on iOS    
  appropriateFor: nil, // only meaningful for “replace” file operations    
  create: true // whether to create the system directory if it doesn’t already exist
)
```

* Checking URL files:

```swift
var isFileURL: Bool  // is this a file URL (whether file exists or not) or something else?
func resourceValues(for keys: [URLResourceKey]) throws -> [URLResourceKey:Any]? 
// Example keys: .creationDateKey, .isDirectoryKey, .fileSizeKey

// Reading Files
init(contentsOf: URL, options: Data.ReadingOptions) throws 

// Writing Files
func write(to url: URL, options: Data.WritingOptions) throws -> Bool //options can .atomic
```

* Write atomic - write to a temp file and then swap



## Demo

* Need unique names when adding files to FileSystem

```swift
// Using uniqued extention to get Untitled1, Untitled2 etc.
let uniqueName = name.uniqued(withRespectTo: documentNames.values)
```

