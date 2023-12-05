//
//  ImageCircle.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 30/11/2023.
//

import SwiftUI

struct ImageCircle: View {
    
    @StateObject var loader: ImageLoadingViewModel
    
    init(url: String, key: String) {
        // !!! init of state object _
        _loader =  StateObject(wrappedValue: ImageLoadingViewModel(url: url, key: key))
    }
    
    var body: some View {
        ZStack {
            if loader.isLoading {
                ProgressView()
            } else if let image = loader.image {
                Image(uiImage: image)
                    .resizable()
                    .clipShape(.circle)
            }
        }
    }
}

#Preview {
    ImageCircle(url: "https://via.placeholder.com/600/92c952", key: "1")
        .frame(width: 75, height: 75)
        .previewLayout(.sizeThatFits)
}
