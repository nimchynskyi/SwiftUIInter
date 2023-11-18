//
//  Typealias.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 18/11/2023.
//

import SwiftUI

struct MovieModel {
    let title: String
    let director: String
    let count: Int
}

typealias TVModel = MovieModel

struct Typealias: View {
    
    @State var item1: MovieModel = MovieModel(title: "Movie title", director: "Joe", count: 5)
    @State var item2: TVModel = TVModel(title: "TV title", director: "Emmily", count: 10)
    
    var body: some View {
        VStack {
            Text(item1.title)
            Text(item1.director)
            Text("\(item1.count)")
            
            Spacer()
            
            Text(item2.title)
            Text(item2.director)
            Text("\(item2.count)")
        }
    }
}

#Preview {
    Typealias()
}
