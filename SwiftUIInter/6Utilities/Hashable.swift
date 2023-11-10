//
//  Hashable.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 11/11/2023.
//

import SwiftUI

struct CustomModel: Hashable {
    let title: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
    }
}

struct HashableView: View {
    
    let data: [CustomModel] = [
        CustomModel(title: "One"),
        CustomModel(title: "Two"),
        CustomModel(title: "Three"),
        CustomModel(title: "Four"),
        CustomModel(title: "Five"),
    ]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 40) {
                ForEach(data, id: \.self) { item in
                    Text(item.hashValue.description)
                        .font(.headline)
                }
            }
        }
    }
}

#Preview {
    HashableView()
}
