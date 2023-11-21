//
//  Subscriber.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 20/11/2023.
//

import SwiftUI
import Combine

class SubscriberViewModel: ObservableObject {
    
    // @Published setting up a publisher - publish values over time
    @Published var count: Int = 0
    // good for one publisher, just assign timer = Timer ..., no need to .store(...)
    // var timer: AnyCancellable?

    // can .store(...) multiple
    var cancellables = Set<AnyCancellable>()
    
    @Published var textFieldText: String = ""
    
    init() {
        setUpTimer()
    }
    
    func setUpTimer() {
        Timer
            .publish(every: 1, on: .main, in: .common)
            .autoconnect()
            .sink { [weak self] _ in
                
                // check if self is valid, no need to use '?
                guard let self = self else { return }
                
                self.count += 1
                
                // cancel when reach 10s
                if self.count >= 10 {
                    for item in self.cancellables { // to cancel everything in set cancellables
                        item.cancel()
                    }
                }
            }
            .store(in: &cancellables)
    }
}

struct SubscriberView: View {
    
    @StateObject var vm = SubscriberViewModel()
    
    var body: some View {
        VStack {
            Text("\(vm.count)")
                .font(.largeTitle)
            
            TextField("Type something...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(.tertiary)
                .clipShape(.buttonBorder)
        }
        .padding()
    }
}

#Preview {
    SubscriberView()
}
