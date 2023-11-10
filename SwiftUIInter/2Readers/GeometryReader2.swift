//
//  GeometryReader2.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 10/11/2023.
//

import SwiftUI

struct GeometryReaderView2: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(.red)
                    .frame(width: geometry.size.width * 0.6666)
                
                Rectangle()
                    .fill(.blue)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    GeometryReaderView2()
}
