//
//  AccessibilityText.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 01/12/2023.
//

import SwiftUI

// Dynamic Text

struct AccessibilityText: View {
    
    @Environment(\.sizeCategory) var sizeCategory
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(0..<10) { _ in
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Image(systemName: "accessibility")
                                .font(.system(size: 30))
                            
                            Text("Welcome to this app!")
                                .truncationMode(.tail)
                        }
                        .font(.title)
                        
                        Text("This is some longer text that expands to multiple lines.")
                            .font(.subheadline)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .lineLimit(3)
                            .minimumScaleFactor(sizeCategory.customMinScaleFactor)
                    }
                    //.frame(height: 100)
                    .background(.red)
                }
            }
            .listStyle(PlainListStyle())
            .navigationTitle("Hello, world!")
        }
    }
}

extension ContentSizeCategory {
    var customMinScaleFactor: CGFloat {
        switch self {
        case .extraSmall, .small, .medium:
            return 1.0
        case .large, .extraLarge, .extraExtraLarge:
            return 0.8
        default:
            return 0.6
        }
    }
}

#Preview {
    AccessibilityText()
}
