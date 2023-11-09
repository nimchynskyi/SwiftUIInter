# Personal SwiftUI Code Templates & Boilerplate code

## Gestures 
- ### 1 - Long Tap 
  - ```.onLongPressGesture {} perform: {}```
  - ```minimumDuration``` & ```maximumDistance``` modifiers
- ### 2 - Magnification
  - ```.gesture(MagnifyGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - CGFloat ```value.magnification``` & ```value.velocity``` 
  - Magnification with ```spring()``` animation
  - Instagram photo viewer clone for demo
- ### 3 - Rotation
  - ```.gesture(MagnifyGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - CGFloat ```value.rotation```
  - Type ```Angle(degrees: x)```
  - Rotation with ```spring()``` animation
- ### 4 - Drag/Swipe
  - ```.gesture(DragGesture())```
  - ```onChanged``` & ```onEnded``` modifiers
  - Edit scale & rotate on swipe (Tinder card example)
  - Swipe up/down to show/hide (Sign Up example)
  - Gestures with ```spring()``` animation

## Readers
- ### 5 - ScrollViewReader
  - Perform actions inside ```ScrollView```, such as auto-scroll to any member
  - Set custom value and anchor ```.top```, ```.bottom```, ```.center```
  - Scroll with animations
