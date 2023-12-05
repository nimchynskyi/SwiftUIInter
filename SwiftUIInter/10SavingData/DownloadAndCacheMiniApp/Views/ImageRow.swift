//
//  ImageRow.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 30/11/2023.
//

import SwiftUI

struct ImageRow: View {
    
    let model: PhotoModel
    
    var body: some View {
        HStack {
            ImageCircle(url: model.url, key: "\(model.id)")
                .frame(width: 75, height: 75)
            
            VStack(alignment: .leading) {
                Text(model.title)
                    .font(.headline)
                
                Text(model.url)
                    .foregroundStyle(.gray)
                    .italic()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
}

#Preview {
    ImageRow(model: PhotoModel(albumId: 1, id: 1, title: "test", url: "https://via.placeholder.com/600/92c952", thumbnailUrl: "https://via.placeholder.com/600/92c952"))
        .padding()
        .previewLayout(.sizeThatFits)
}
