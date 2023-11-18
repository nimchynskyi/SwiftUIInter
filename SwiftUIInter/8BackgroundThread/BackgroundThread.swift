//
//  BackgroundThread.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 18/11/2023.
//

import SwiftUI

class BackgroundThreadViewModel: ObservableObject {
    
    @Published var dataArray: [String] = []
    
    func fetchData() {
        
        // on main thread
         
//        let newData = downloadData()
//        dataArray = newData
         
         
        
        // on background thread WITHOUT qos specified
        // shows this warning below, because ui MUST be updated on the main thread
        // Publishing changes from background threads is not allowed; make sure to publish values from the main thread
        // (via operators like receive(on:)) on model updates.
         
//        DispatchQueue.global().async {
//            let newData = self.downloadData()
//            self.dataArray = newData
//        }
         
         
        
        // on background thread WITHOUT qos specified
        // this time withoud warning, becasue i put code that triggers ui refresh on the main thread
        
//        DispatchQueue.global().async {
//            let newData = self.downloadData()
//            DispatchQueue.main.async {
//                self.dataArray = newData
//            }
//        }
         
        
        // on background thread WITH qos specified
        // this time withoud warning, becasue i put code that triggers ui refresh on the main thread
        
        DispatchQueue.global(qos: .background).async {
            
            let newData = self.downloadData()
            
            print("Check 1: \(Thread.isMainThread)")
            print("Check 1: \(Thread.current)")
            
            DispatchQueue.main.async {
                self.dataArray = newData
                print("Check 2: \(Thread.isMainThread)")
                print("Check 2: \(Thread.current)")
            }
        }
    }
    
    private func downloadData() -> [String] {
        var data: [String] = []
        
        for x in 0..<100 {
            data.append("\(x)")
            print(data)
        }
        return data
    }
}

struct BackgroundThread: View {
    
    @StateObject var vm = BackgroundThreadViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                Text("LOAD DATA")
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .onTapGesture {
                        vm.fetchData()
                    }
                
                ForEach(vm.dataArray, id: \.self) { item in
                    Text(item)
                        .font(.headline)
                        .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    BackgroundThread()
}
