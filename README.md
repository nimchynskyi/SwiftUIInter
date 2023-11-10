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
  > **🚨NOTE: Try not to use too often - excessive usage leads to peformance degradation!**
  - Track screen/object dimensions/size(width & height) dynamically
  - `GeometryReader { geometry in }`
  - If you can avoid `GeomertyReader` - ***don't*** use it
