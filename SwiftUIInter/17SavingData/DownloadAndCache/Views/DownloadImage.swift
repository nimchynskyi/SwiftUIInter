//
//  DownloadImage.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 27/11/2023.
//

import SwiftUI

struct DownloadImage: View {
    
    @StateObject var vm = DownloadImageViewModel()
    
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
    DownloadImage()
}
