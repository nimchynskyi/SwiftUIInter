//
//  MultipleSheets.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}

// 1 - use binding (not adviced)
// 2 - use multiple .sheets
// 3 - use $item (best)

struct MultipleSheetsView1: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting title")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                selectedModel = RandomModel(title: "One")
                showSheet.toggle()
            }
            .buttonStyle(.bordered)
            
            Button("Button 2") {
                selectedModel = RandomModel(title: "Two")
                showSheet.toggle()
            }
            .buttonStyle(.bordered)
        }
        .sheet(isPresented: $showSheet, content: {
            // sheet is rendered before button clicks that choose title
            NextScreen(selectedModel: $selectedModel)
        })
    }
}

struct NextScreen: View {
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsView1()
}
