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
  >
  > **🚨 NOTE: Try not to use too often - excessive usage leads to peformance degradation!**
  - Track screen/object dimensions/size(width & height) dynamically
  - `GeometryReader { geometry in }`
  - If you can avoid `GeomertyReader` - ***don't*** use it

## Multiple Sheets Problem
>
> **Often wrong sheet being presented when selecting which sheet to present for the first time.**
> **This behaviour caused by sheet being rendered before selecting which model to present.**
>
- ### `$selectedModel` binding
  >
  > Not advised as it might ruin complex logic views (e.g. some views can require `selectedModel` to be static)
  - Use binding on model `@Binding var selectedModel: RandomModel` to track changes
  - Bind it to present on `NextScreen(selectedModel: $selectedModel)`

- ### Use of Multiple Sheets **(worst)**
  >
  > 🐌 Worst overall, okay to use for couple sheets
  - Use of multiple `.sheet(isPresented: $showSheet, content: {})` for each button
  - Clutters code

- ### `$item` binding **(best)**
  >
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
>
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
>
> Local Database on the iOS that persists between sessions.
>
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
>
> Manage how tasks are running to control how CPU is used.
>
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
- Very important if the app has tons of API/DB calls
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

  - 🚨 Safely unwrap `self` so it is no longer optional(no need to write `self?.xxxx`)

    ```swift
    guard let self = self else { return }
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

Three ways to use escaping closure:

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

## Codable, Decodable and Encodable

### 🚨 *Codable = Decodable + Encodable*

- Decodable - type that can decode itself from an external representation (allows to initialize model from some data)

  ```swift
  self.someModel = try? JSONDecoder().decode(SomeModel.self, from: data)
  ```

- Encodable - type that can encode itself to an external representation (allows to initialize data from some model)

  ```swift
  let jsonData = try? JSONEncoder().encode(data)
  ```

- Decodable and Encodable always need their own initializers, Codable - **DOESN'T**, it automatically handles initializers and containers

## Downloading JSON from API

- ### `URLSession` and escaping closures
  >
  > **🚨 `dataTask` automatically goes to the background thread**
  - Generic download function to use on different URLs across the application
  - Downloading data occurs on the main thread (triggers UI refresh)
  - `[weak self]` is used to avoid cases with strong references
  - MVVM architecture with custom models
  - Used this public **[API](https://jsonplaceholder.typicode.com/posts)**

- ### Combine

  - Combine is new Apple framework that takes advantage of using publishers and subscribers
  - `.dataTaskPublisher` structure basically the same as usual `.dataTask`, but has different logic:
    1. create a publisher
    2. subscribe publisher on background thread
    3. receive on main thread
    4. tryMap (check that the data is good)
    5. decode (decode data into PostModels)
    6. sink (put the item in the app)
    7. store (cancel subscription if needed)
  - `.dataTaskPublisher` has to be **cancellable**, because it publish values over time

    ```swift
    var cancellables = Set<AnyCancellable>()
    ...
    .store(in: &cancellables)
    ```

  - Separate `.tryMap` logic for cleaner code

    ```swift
    .tryMap(handleOutput)
    ...
    func handleOutput(output: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
            let response = output.response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
            throw URLError(.badServerResponse)
        }
        return output.data
    }
    ```

    Instead of this:

    ```swift
    .tryMap { data, response -> Data in
        guard
            let response = response as? HTTPURLResponse,
            response.statusCode >= 200 && response.statusCode < 300 else {
                throw URLError(.badServerResponse)
        }
        return data
    }
    ```

  - `[weak self]` is used to avoid cases with strong references
  - MVVM architecture with custom models
  - Used this public **[API](https://jsonplaceholder.typicode.com/posts)**

## Timer & `.onReceive`
>
> Timer is actually a publisher - object that publishes values over time and subsciber is needed to listen

- Declare timer:

  ```swift
  let timer = Timer.publish(every: 1.0, on: .main, in: .common).autoconnect()
  ```

  And use on view:

  ```swift
  .onReceive(timer, perform: { _ in
      updateTimeRemaining()
  })
  ```

- Important to use `.autoconnect()` for timer to automatically connect and start
- Examples of using Timer:
  - Current Time
  - Countdown
  - Countdown to date in the future
  - Animation counter

## Subscriber

- Combine framework & MVVM architecture
- Combine two publishers with `.combineLatest()` and use `.sink()` to manage logic.\
  For example, there are two `@Published` variables:

  ```swift
  @Published var count: Int = 0
  @Published var textIsValid: Bool = false
  ```

  I can combine them like this:

  ```swift
   $textIsValid
      .combineLatest($count)
  ```

  And then proceed adding some logic with `.sink()`:

  ```swift
  $textIsValid
      .combineLatest($count)
      .sink { [weak self] isValid, count in
          guard let self = self else { return }
          if isValid && count >= 10 {
              self.showButton = true
          } else {
              self.showButton = false
          }
      }
  ```

  `.sink()` initializer will have two receiveValues:

  ```swift
  (Published<Bool>.Publisher.Output, Published<Int>.Publisher.Output)
  ```

  It's based on previous `.combine()`, in this example they are `Bool`(`textIsValid`) and `Int`(`count`).

- 🚨 If app logic is complex use `.debounce()`. Useful in scenarios such as API/DB calls, search etc.\
  This will start "notifying" subsribers about changes only after user stopped typing and 0.5 seconds passed:

  ```swift
  $textFieldText
      .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
      ...
  ```

- Always store publisher in cancellables, like this `.store(in: &cancellables)` to be able cancel stored activities or actions.
  > Frees up any allocated resources and also stops side effects such as timers, network access, or disk I/O.

  For example, cancel timer when it reacher 10 seconds:

  ```swift
  .sink { [weak self] _ in
      guard let self = self else { return }

      self.count += 1

      if self.count >= 10 {
          for item in self.cancellables {
              item.cancel()
          }
      }
  }
  ```

- In this particular example single cancellable is okay and there is no need to `.store(...)`

  ```swift
  var timer: AnyCancellable?
  timer = Timer
      .publish(...)
      .autoconnect()
      .sink { ... }
  ```

- Example on checking text field character count

## Saving data

### FileManager

- Great for videos, images, audifiles, JSON data etc.
- Use sparingly as all data is saved on user's device
- When downloading images from internet, it's better to save them in the FileManager
- Singleton `LocalFileManager` class to manage data between views etc. (Any in-appscreen can read from/save to File Manager)
- Save different types of images:

  ```swift
  // jpg
  guard let data = image.jpegData(compressionQuality: 1.0) else {
      print("Error getting data.")
      return
  }

  // png
  guard let data = image.pngData( ... )
  ```

- 3 most common directories to save a file to:

  ```swift
  // user-generated content (will be auto backed up by iCloud)
  let directory1 = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

  // files that can be regenerated, e.g. cache
  let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask)

  // temp files
  let directory3 = FileManager.default.temporaryDirectory
  ```

    Example directories paths on my device:

    ```swift
    // directory1
    file:///var/mobile/Containers/Data/Application/79C3FE28-3CA9-40BD-BBC9-A7E37335B4A5/Documents/

    // directory2
    file:///var/mobile/Containers/Data/Application/79C3FE28-3CA9-40BD-BBC9-A7E37335B4A5/Library/Caches/

    // directory3
    file:///private/var/mobile/Containers/Data/Application/79C3FE28-3CA9-40BD-BBC9-A7E37335B4A5/tmp/
    ```

- Save images:

  ```swift
  func saveImage(image: UIImage, name: String) {

      guard
          let data = image.jpegData(compressionQuality: 1.0),
          let path = getPathForImage(name: name) else {
          print("Error getting data.")
          return
      }

      do {
          try data.write(to: path)
          print("Success saving!")
      } catch let error {
          print("Error saving. \(error)")
      }
  }
  ```

- Delete image:

  ```swift
  func deleteImage(name: String) -> String {
      guard
          let path = getPathForImage(name: name)?.path,
          FileManager.default.fileExists(atPath: path) else {
          return "Error getting path."
      }

      do {
          try FileManager.default.removeItem(atPath: path)
          return "Successfully deleted"
      } catch let error {
          return "Error deleting image. \(error)"
      }
  }
  ```

- Create folder:

  ```swift
  try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
  ```

  <img width="1076" alt="Screenshot 2023-11-26 at 16 07 53" src="https://github.com/fsociety010101/SwiftUIInter/assets/59197830/35998350-75a8-448b-8b9e-e9513377cc37">

- Delete folder:

  ```swift
  try FileManager.default.removeItem(atPath: path)
  ```
