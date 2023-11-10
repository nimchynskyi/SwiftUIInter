//
//  MultipleSheets2.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI

// 1 - use binding (not adviced)
// 2 - use multiple .sheets
// 3 - use $item (best)

struct MultipleSheetsView2: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "Starting title")
    @State var showSheet: Bool = false
    @State var showSheet2: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button 1") {
                showSheet.toggle()
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $showSheet, content: {
                NextScreen2(selectedModel: RandomModel(title: "One"))
            })
            
            Button("Button 2") {
                showSheet2.toggle()
            }
            .buttonStyle(.bordered)
            .sheet(isPresented: $showSheet2, content: {
                NextScreen2(selectedModel: RandomModel(title: "Two"))
            })
        }
    }
}

struct NextScreen2: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

#Preview {
    MultipleSheetsView2()
}
