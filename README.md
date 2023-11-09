# Personal SwiftUI Code Templates & Boilerplate code

## Gestures: 
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
