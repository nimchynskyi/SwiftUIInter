//
//  AccessibilityText.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 01/12/2023.
//

import SwiftUI

// DynamicText

struct AccessibilityText: View {
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "accessibility")
                            Text("Welcome to this app!")
                        }
                        .font(.title)
                        
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    .frame(height: 100)
                    .background(.red)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Hello, world!")
        }
    }
}

#Preview {
    AccessibilityText()
}
