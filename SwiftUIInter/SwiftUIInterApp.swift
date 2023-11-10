//
//  SwiftUIInterApp.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 09/11/2023.
//

import SwiftUI

@main
struct SwiftUIInterApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                List {
                    Section(header: Text("Gestures")) {
                        NavigationLink(destination: LongPressGestureView())         { Text("Long Tap") }
                        NavigationLink(destination: MagnificationGestureView())     { Text("Magnify Gesture") }
                        NavigationLink(destination: RotationGestureView())          { Text("Rotate Gesture") }
                        NavigationLink(destination: DragGestureView())              { Text("Drag Gesture (Example 1)") }
                        NavigationLink(destination: DragGestureView2())             { Text("Drag Gesture (Example 2)") }
                    }
                    
                    Section(header: Text("Readers")) {
                        NavigationLink(destination: ScrollViewReaderView())         { Text("ScrollViewReader") }
                        NavigationLink(destination: GeometryReaderView())           { Text("GeometryReader (Example 1)") }
                        NavigationLink(destination: GeometryReaderView2())           { Text("GeometryReader (Example 2)") }
                    }
                }
                .navigationTitle("SwiftUI Code DB")
            }
        }
    }
}
