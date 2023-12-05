//
//  DownloadImage.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 27/11/2023.
//

import SwiftUI

struct ImageApp: View {
    
    @StateObject var vm = ImageAppViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(vm.dataArray) { model in
                    ImageRow(model: model)
                }
            }
            .navigationTitle("Downloading Images")
        }
    }
}

#Preview {
    ImageApp()
}
