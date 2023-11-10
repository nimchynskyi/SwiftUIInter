# Personal SwiftUI Code Templates & Boilerplate code

## Gestures 
- ### 1 - Long Tap
  - Detect, track & customize long taps
  - ```.onLongPressGesture {} perform: {}```
  - ```minimumDuration``` & ```maximumDistance``` modifiers
- ### 2 - Magnification
  - Detect, track & customize magnification gestures (2 fingers)
  - ```.gesture(MagnifyGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - CGFloat ```value.magnification``` & ```value.velocity``` 
  - Magnification with ```spring()``` animation
  - Instagram photo viewer clone for demo
- ### 3 - Rotation
  - Detect, track & customize rotation gestures (2 fingers)
  - ```.gesture(MagnifyGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - CGFloat ```value.rotation```
  - Type ```Angle(degrees: x)```
  - Rotation with ```spring()``` animation
- ### 4 - Drag/Swipe
  - Detect, track & customize drag/swipe gestures
  - ```.gesture(DragGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - Edit scale & rotate on swipe (Tinder card example)
  - Swipe up/down to show/hide (Sign Up example)
  - Gestures with ```spring()``` animation

## Readers
- ### 5 - ScrollViewReader
  - Perform actions inside ```ScrollView```
  - Auto-scroll to any member: ```.onChange(of: scrollToIndex)```
  - Set custom value and anchor: ```proxy.scrollTo(value, anchor: .top)```
  - Scroll with animation
- ### 6 - GeometryReader
  > **🚨 NOTE: Try not to use too often - excessive usage leads to peformance degradation!**
  - Track screen/object dimensions/size(width & height) dynamically
  - `GeometryReader { geometry in }`
  - If you can avoid `GeomertyReader` - ***don't*** use it

 ## Multiple Sheets Problem
> **Often wrong sheet being presented when selecting which sheet to present for the first time.**
> **This behaviour caused by sheet being rendered before selecting which model to present.**
> 
- ### 7 - `$selectedModel` binding
  > Not advised as it might ruin complex logic views (e.g. some views can require `selectedModel` to be static)
  - Use binding on model `@Binding var selectedModel: RandomModel` to track changes
  - Bind it to present on `NextScreen(selectedModel: $selectedModel)`
- ### 8 - Use of Multiple Sheets **(worst)**
  > 🐌 Worst overall, okay to use for couple sheets
  - Use of multiple `.sheet(isPresented: $showSheet, content: {})` for each button
  - Clutters code
- ### 9 - `$item` binding **(best)**
  > 🏆 Best method
  - Use of single `.sheet(item: $selectedModel) { model in }` with `item:` parameter and pass `$selectedModel` binding 
  - Clean code
 
## Other
- ### 10 - Mask 
  - `.mask` adapts it's child view to master view
  - Used with `GeometryReader` to track `.overlay` dimensions
  - 🚨 Important to use `.allowsHitTesting(false)` to forbid `GeometryReader` register taps
  - Five-star rating example with animation on change

## Sounds & Haptics
- ### 11 - Sound Effects
  - Add custom sound effects
  - Apple's `AVKit` Library
  - Use of **Singleton** class with instance of `SoundManager()`
  - Use of `enum: String` to choose the sound
  - Error handling
- ### 12 - Haptics & Vibrations
  - Use native iOS haptics with `UINotificationFeedbackGenerator` & `UIImpactFeedbackGenerator`
  - Use of **Singleton** class with instance of `HapticManager()`
  - Two functions to choose between `notification` and `impact` haptics
  - Try to use native haptics as they are familiar to users
- ### 13 - Local Notifications
  - Apple's `UserNotifications` Library
  - Request permission first with `UNUserNotificationCenter.current().requestAuthorization(options: options)`
  - Customizable options with `UNAuthorizationOptions` such as `.alert, .sound, .badge` etc.
  - 3 types of notification trigger:
    - Time `UNTimeIntervalNotificationTrigger`
    - Calendar `UNCalendarNotificationTrigger`
    - Location `UNLocationNotificationTrigger`
  - Trigger with `UNUserNotificationCenter.current().add(request)`
  - Cancel pending/delivered notifications `removeAllPendingNotificationRequests`, `removeAllDeliveredNotifications()`
