//
//  Haptics.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI

class HapticManager {
    
    static let instance = HapticManager() // Singleton
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct Haptics: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("Success") { HapticManager.instance.notification(type: .success) }.buttonStyle(.borderedProminent)
            Button("Warning") { HapticManager.instance.notification(type: .warning) }.buttonStyle(.borderedProminent)
            Button("Error") { HapticManager.instance.notification(type: .error) }.buttonStyle(.borderedProminent)
            
            Divider()
            
            Button("Soft") { HapticManager.instance.impact(style: .soft) }.buttonStyle(.bordered)
            Button("Light") { HapticManager.instance.impact(style: .light) }.buttonStyle(.bordered)
            Button("Medium") { HapticManager.instance.impact(style: .medium) }.buttonStyle(.bordered)
            Button("Rigid") { HapticManager.instance.impact(style: .rigid) }.buttonStyle(.bordered)
            Button("Heavy") { HapticManager.instance.impact(style: .heavy) }.buttonStyle(.bordered)
        }
    }
}

#Preview {
    Haptics()
}
