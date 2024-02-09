# Access Control
* Restricts access to code from other source files + modules

  

## Modules & Source Files
* **Module** is a framework that can be **imported**

* Each build target is treated as a seperate module

* **Source file** is a single source code file within a module with definitions for types, funcs etc.

  

## Access Levels
* **Open / Public Access** - Can be used within **any** source file from **any module** (as long as imported)
```swift
public class SomePublicClass {}
public var somePublicVariable = 0
```
* **Internal Access** - Entities to be used within any source file from **defining module** (DEFAULT)
```swift
// Not needed as default
internal class SomeInternalClass {} 
internal let someInternalConstant = 0
```
* **File-private Access** - Restricts the use of an entity to its **own** defining **source file**
```swift
fileprivate class SomeFilePrivateClass {}
fileprivate func someFilePrivateFunction() {}
```
* **Private Access** - Use of an entity to the enclosing declaration, and to extensions of that declaration that are in the **same file**
```swift
private class SomePrivateClass {}
private func somePrivateFunction() {}
```

### Unit Test Target

* Can access any internal entity if you mark the import declaration as **@testable**



## Custom Types

* Access control of a type affects its members ( prop / methods etc.)
* Tuple becomes access type of the most restrictive