//
//  MultipleSheets3.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI

// 1 - use binding (not adviced)
// 2 - use multiple .sheets
// 3 - use $item (best)

struct MultipleSheetsView3: View {
    
    @State var selectedModel: RandomModel? = nil
    
    var body: some View {
        VStack(spacing: 20) {
            ScrollView {
                ForEach(0..<50) { index in
                    Button("Button \(index)") {
                        selectedModel = RandomModel(title: "\(index)")
                    }
                    .buttonStyle(.bordered)
                }
            }
            .scrollIndicators(.hidden)
        }
        .sheet(item: $selectedModel) { model in
            NextScreen3(selectedModel: model)
        }
    }
}

struct NextScreen3: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsView3()
}
