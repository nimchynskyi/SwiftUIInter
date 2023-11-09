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
                    NavigationLink(destination: LongPressGesture())         { Text("Long Tap") }
                    NavigationLink(destination: MagnificationGesture())     { Text("Magnify Gesture") }
                    NavigationLink(destination: RotationGesture())          { Text("Rotate Gesture") }
                }
                .navigationTitle("Gestures")
            }
        }
    }
}
