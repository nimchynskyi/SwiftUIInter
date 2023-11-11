//
//  Arrays.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 11/11/2023.
//

import SwiftUI

struct UserModel: Identifiable {
    let id = UUID().uuidString
    let name: String?
    let points: Int
    let isVerified: Bool
}

class ArrayModificationViewModel: ObservableObject {
    
    @Published var dataArray: [UserModel] = []
    @Published var filteredArray: [UserModel] = []
    @Published var mappedArray: [String] = []
    
    init() {
        getUsers()
        updateFilteredArray()
    }
    
    func updateFilteredArray() {
        
        // sort
        /*
        filteredArray = dataArray.sorted { user1, user2 in
            return user1.points > user2.points
        }
        same thing
        filteredArray = dataArray.sorted(by: { $0.points > $1.points })
         */
        
        
        
        //filter
        /*
         filteredArray = dataArray.filter({ user in
         return user.isVerified
         })
         
         filteredArray = dataArray.filter({ $0.isVerified })
         */
        
        
        
        // map
        /*
         mappedArray = dataArray.map({ user in
         return user.name
         })
         
         mappedArray = dataArray.map({ $0.name })
         */
        
        
        
        // better mapping if array has nil values
        /*
         mappedArray = dataArray.compactMap({ user in
         return user.name
         })
         
         mappedArray = dataArray.compactMap({ $0.name })
         */
        
        mappedArray = dataArray
            .sorted(by: { $0.points > $1.points })
            .filter({ $0.isVerified })
            .compactMap({ $0.name })
    }
    
    func getUsers() {
        let user1 = UserModel(name: "Nick", points: 5, isVerified: true)
        let user2 = UserModel(name: "Chris", points: 0, isVerified: false)
        let user3 = UserModel(name: "Joe", points: 20, isVerified: true)
        let user4 = UserModel(name: "Emily", points: 50, isVerified: false)
        let user5 = UserModel(name: "nil", points: 45, isVerified: true)
        let user6 = UserModel(name: "Jason", points: 23, isVerified: false)
        let user7 = UserModel(name: "Sarah", points: 76, isVerified: true)
        let user8 = UserModel(name: "nil", points: 45, isVerified: false)
        let user9 = UserModel(name: "Steve", points: 1, isVerified: true)
        let user10 = UserModel(name: "Amanda", points: 100, isVerified: false)
        
        self.dataArray.append(contentsOf: [
            user1, user2, user3, user4, user5, user6, user7, user8, user9, user10
        ])
    }
}

struct Arrays: View {
    
    @StateObject var vm = ArrayModificationViewModel()
    
    var body: some View {
        ScrollView {
            ForEach(vm.mappedArray, id: \.self) { name in
                Text(name)
                    .font(.title)
            }
            //            VStack(spacing: 10) {
            //                ForEach(vm.filteredArray) { user in
            //                    VStack(alignment: .leading) {
            //                        Text(user.name)
            //                            .font(.headline)
            //                        HStack {
            //                            Text("Point: \(user.points)")
            //                            Spacer()
            //                            if user.isVerified {
            //                                Image(systemName: "flame.fill")
            //                            }
            //                        }
            //                    }
            //                    .foregroundStyle(.white)
            //                    .padding()
            //                    .background(.blue)
            //                    .clipShape(.buttonBorder)
            //                    .padding(.horizontal)
            //                }
            //            }
        }
    }
}

#Preview {
    Arrays()
}
