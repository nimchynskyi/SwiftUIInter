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
            Circle()
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
    ImageRow(model: PhotoModel(albumId: 1, id: 1, title: "test", url: "url", thumbnailUrl: "thumbnailUrl"))
        .padding()
        .previewLayout(.sizeThatFits)
}
