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
                        NavigationLink(destination: GeometryReaderView2())          { Text("GeometryReader (Example 2)") }
                    }
                    
                    Section(header: Text("Multiple Sheets Problem")) {
                        NavigationLink(destination: MultipleSheetsView1())          { Text("Solution 1 - $selectedModel binding") }
                        NavigationLink(destination: MultipleSheetsView2())          { Text("Solution 2 - multiple sheets usage") }
                        NavigationLink(destination: MultipleSheetsView3())          { Text("Solution 3 - $item binding 🏆") }
                    }
                    
                    Section(header: Text("Mask")) {
                        NavigationLink(destination: MaskView())                     { Text("Use of .mask") }
                    }
                    
                    Section(header: Text("Sounds & Haptics")) {
                        NavigationLink(destination: Sounds())                       { Text("Custom sounds") }
                        NavigationLink(destination: Haptics())                      { Text("Native Haptics") }
                        NavigationLink(destination: LocalNotifications())           { Text("Local Notifications") }
                    }
                    
                    Section(header: Text("Utilities")) {
                        NavigationLink(destination: HashableView())                 { Text("Hashable") }
                        NavigationLink(destination: Arrays())                       { Text("Arrays Data Manipulation")}
                    }
                }
                .navigationTitle("SwiftUI Code DB")
            }
        }
    }
}
