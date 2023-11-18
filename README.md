# Personal SwiftUI Code Templates & Boilerplate code

## Gestures 
- ### Long Tap
  - Detect, track & customize long taps
  - ```.onLongPressGesture {} perform: {}```
  - ```minimumDuration``` & ```maximumDistance``` modifiers
- ### Magnification
  - Detect, track & customize magnification gestures (2 fingers)
  - ```.gesture(MagnifyGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - CGFloat ```value.magnification``` & ```value.velocity``` 
  - Magnification with ```spring()``` animation
  - Instagram photo viewer clone for demo
- ### Rotation
  - Detect, track & customize rotation gestures (2 fingers)
  - ```.gesture(MagnifyGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - CGFloat ```value.rotation```
  - Type ```Angle(degrees: x)```
  - Rotation with ```spring()``` animation
- ### Drag/Swipe
  - Detect, track & customize drag/swipe gestures
  - ```.gesture(DragGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - Edit scale & rotate on swipe (Tinder card example)
  - Swipe up/down to show/hide (Sign Up example)
  - Gestures with ```spring()``` animation

## Readers
- ### ScrollViewReader
  - Perform actions inside ```ScrollView```
  - Auto-scroll to any member: ```.onChange(of: scrollToIndex)```
  - Set custom value and anchor: ```proxy.scrollTo(value, anchor: .top)```
  - Scroll with animation
- ### GeometryReader
  > **🚨 NOTE: Try not to use too often - excessive usage leads to peformance degradation!**
  - Track screen/object dimensions/size(width & height) dynamically
  - `GeometryReader { geometry in }`
  - If you can avoid `GeomertyReader` - ***don't*** use it

 ## Multiple Sheets Problem
> **Often wrong sheet being presented when selecting which sheet to present for the first time.**
> **This behaviour caused by sheet being rendered before selecting which model to present.** 
- ### `$selectedModel` binding
  > Not advised as it might ruin complex logic views (e.g. some views can require `selectedModel` to be static)
  - Use binding on model `@Binding var selectedModel: RandomModel` to track changes
  - Bind it to present on `NextScreen(selectedModel: $selectedModel)`
- ### Use of Multiple Sheets **(worst)**
  > 🐌 Worst overall, okay to use for couple sheets
  - Use of multiple `.sheet(isPresented: $showSheet, content: {})` for each button
  - Clutters code
- ### `$item` binding **(best)**
  > 🏆 Best method
  - Use of single `.sheet(item: $selectedModel) { model in }` with `item:` parameter and pass `$selectedModel` binding 
  - Clean code
 
## Mask
- `.mask` adapts it's child view to master view
- Used with `GeometryReader` to track `.overlay` dimensions
- 🚨 Important to use `.allowsHitTesting(false)` to forbid `GeometryReader` register taps
- Five-star rating example with animation on change

## Sounds & Haptics
- ### Sound Effects
  - Add custom sound effects
  - Apple's `AVKit` Library
  - Use of **Singleton** class with instance of `SoundManager()`
  - Use of `enum: String` to choose the sound
  - Error handling
- ### Haptics & Vibrations
  - Use native iOS haptics with `UINotificationFeedbackGenerator` & `UIImpactFeedbackGenerator`
  - Use of **Singleton** class with instance of `HapticManager()`
  - Two functions to choose between `notification` and `impact` haptics
  - Try to use native haptics as they are familiar to users
- ### Local Notifications
  - Apple's `UserNotifications` Library
  - Request permission first with `UNUserNotificationCenter.current().requestAuthorization(options: options)`
  - Customizable options with `UNAuthorizationOptions` such as `.alert, .sound, .badge` etc.
  - 3 types of notification trigger:
    - Time `UNTimeIntervalNotificationTrigger`
    - Calendar `UNCalendarNotificationTrigger`
    - Location `UNLocationNotificationTrigger`
  - Trigger with `UNUserNotificationCenter.current().add(request)`
  - Cancel pending/delivered notifications `removeAllPendingNotificationRequests`, `removeAllDeliveredNotifications()`

## Utilities
- ### Hashable
  - Unique hash values for custom models/types
  - Alternative to `Identifiable` as sometimes UUID is not needed
  - Can generate hash value based on model/type variables
  - Usually used in `ForEach` loops
- ### Array Data Manipulation
> 3 main ways to manipulate data in arrays.
> Examples wit MVVM architecture.
  - Sort data with comparator:
  ```swift
    filteredArray = dataArray.sorted(by: { $0.points > $1.points })
  ```
  - Filter unnecessary data out:
  ```swift
    filteredArray = dataArray.filter({ $0.isVerified })
  ```
  - Map data to transform it from one type to another: 
  ```swift
    mappedArray = dataArray.map({ $0.name })
  ```
  - Better mapping with `compactMap` if array has unwanted `nil` values:
  ```swift
    mappedArray = dataArray.compactMap({ $0.name })
  ```
  - Ability to stack filter actions on array:
  ```swift
    mappedArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
  ```

## Core Data
> Local Database on the iOS that persists between sessions.
- ### Core Data with `@FetchRequest`
  [Link](https://github.com/fsociety010101/SwiftUIInterCoreData) to separate project repository.
- ### Core Data with MVVM architecture
  - `NSPersistentContainer` to store cusom entities
  - Custom initializer with error handling
  - Fetch function, alternative to `@FetchRequest`, to fetch all data
  - Add, update and delete items
  - Save item action (Core Data DB transaction after each change)
  - ViewModel inside the View to ensure data managmenet
  - Fully functional user interface written in SwiftUI
- ### Core Data Relationships, predicates and delete rules
  - Singleton instance with `NSPersistentContainer`, `NSManagedObjectContext`, custom initializer
  - ViewModel containing Singleton instance to manage container with custom `add`, `get`, `update` and `delete` functions for each entity.
  - Three custom entities `Business`, `Department` and `Employee` with own attributes
    
    Core Data graph: 
    <img width="896" alt="image" src="https://github.com/fsociety010101/SwiftUIInter/assets/59197830/c60def3f-ee8d-4d04-b86e-69070b61076c">
    
  - Set Delete Rules, such as:
    - `Nullify` - sets all its mentions to null
    - `Cascade` - also deletes all its members e.g. employee gets deleted from deleted department
    - `Deny` - won't delete until empty and has no members
    - `No Action`

## Background Threads
> Manage how tasks are running to control how CPU is used.
- ### Run on main thread
  - API call is completed on the main thread (Thread 1)
  - CPU spikes occurring only on the main thread
    <img width="1052" alt="image" src="https://github.com/fsociety010101/SwiftUIInter/assets/59197830/9b05a9e7-9e75-429f-b13c-b78c635d2d8f">

- ### Run on background thread
  - API call is completed on the background thread using `DispatchQueue.global().async {}`
    > **🚨 NOTE: Using without `DispatchQueue.main.async` is causing an error, because EVERYTHING, including UI refresh, is running on the background threads.**
  - Code that triggers UI refresh must be run in `DispatchQueue.main.async { ... }`
  - CPU spikes occurring on several background threads
  - Main thread (Thread 1) is only used to refresh UI
    <img width="1052" alt="image" src="https://github.com/fsociety010101/SwiftUIInter/assets/59197830/828d4dc4-175f-4aa1-a6ae-89dbae23d66d">

- ### Run on background thread with QoS specified
  - API call is completed on the background thread using `DispatchQueue.global(qos: DispatchQoS.QoSClass).async`
  - Several QoS options:
    - `.default`
    - `.unspecified`
    - `.background` - the quality-of-service class for maintenance or cleanup tasks that you create
    - `.userInitiated` - the quality-of-service class for tasks that prevent the user from actively using your app (can't use app until this loads)
    - `.userInteractive` - the quality-of-service class for user-interactive tasks, such as animations, event handling, or updating your app's user interface (very common)
    - `.utility` - the quality-of-service class for tasks that the user does not track actively
  - Useful code to track threads
    ```swift
    Thread.isMainThread  // returns true or false
    Thread.current       // returns current thread (e.g. number and name)
    ```

## Weak Self
  - Mark tasks that are not important, so they have the abillity to deinitialize
  - Very important if the app has tons of calls
  - For example:
    - This data will be alive and ready to be shown without being deinitialized for 500 seconds. It gathers over time and number of such tasks can be huge which leads to slowdowns.
      ```swift
      DispatchQueue.main.asyncAfter(deadline: .now() + 500) {
          self.data = "some data"
      }
      ```
    - This data will be deinitialized as soon as dismissed, because it marked as `[weak self]`
      ```swift
      DispatchQueue.main.asyncAfter(deadline: .now() + 500) { [weak self] in
            self?.data = "some data"
      }
      ```

## Typealias
  - Provide a new name for an existing data type
    ```swift
    struct MovieModel {
      let title: String
      let director: String
      let count: Int
    }

    typealias TVModel = MovieModel
    ```
  - Create typealias for: 
    - Built-in types (eg: String, Int)
    - User-defined types (e.g: class, struct, enum)
    - Complex types (e.g: closures)
## Escaping closure
  - Three ways to use escaping closure:
    - Plain
      ```swift
      func downloadData(completionHandler: @escaping (_ data: String) -> ()) {
        ...
      }
      ```
    - Using return result model
      ```swift
      func downloadData(completionHandler: @escaping (DownloadResult) -> ()) {
        ...
      }

      struct DownloadResult {
        let data: String
      }
      ```
    - Using typealias
      ```swift
      func downloadData(completionHandler: @escaping DownloadCompletion) {
        ...
      }

      struct DownloadResult {
        let data: String
      }

      typealias DownloadCompletion = (DownloadResult) -> ()
      ```
