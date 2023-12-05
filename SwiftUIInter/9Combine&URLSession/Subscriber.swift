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
    @Published var showButton: Bool = false
    @Published var textIsValid: Bool = false
    @Published var textFieldText: String = ""
    // every time this gets updated (in view, when user types) - it is publishing new value 
    // (like timer e.g. updated every 1 second it publishes value and i am able to run functions every 1 second)
    
    
    // good for one publisher, just assign timer = Timer ..., no need to .store(...)
    // var timer: AnyCancellable?

    // can .store(...) multiple
    var cancellables = Set<AnyCancellable>()
    
    init() {
        setUpTimer()
        addTextFieldSubscriber()
        addButtonSubscriber()
    }
    
    func addTextFieldSubscriber() {
        $textFieldText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // wait until stop for 0.5 seconds, typing in this example, very useful in complex scenarios/logic e.g. search, db calls etc.
            .map { text -> Bool in
                if text.count > 3 { // basically constantly checking if text input is greater than 3
                    return true
                }
                return false
            }
            //.assign(to: \.textIsValid, on: self) // in assign there is no way to make self weak, use sink whenever possible!
            .sink(receiveValue: { [weak self] isValid in
                self?.textIsValid = isValid
            })
            .store(in: &cancellables)
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
                /*
                if self.count >= 10 {
                    for item in self.cancellables { // to cancel everything in set cancellables
                        item.cancel() // trigger cancel using cancellable
                    }
                }
                 */
            }
            .store(in: &cancellables)
    }
    
    func addButtonSubscriber() {
        $textIsValid
            .combineLatest($count)
            .sink { [weak self] isValid, count in
                guard let self = self else { return }
                if isValid && count >= 10 {
                    self.showButton = true
                } else {
                    self.showButton = false
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
            
            // Text(vm.textIsValid.description)
            
            TextField("Type something here...", text: $vm.textFieldText)
                .padding(.leading)
                .frame(height: 55)
                .font(.headline)
                .background(.tertiary)
                .clipShape(.buttonBorder)
                .overlay (
                    ZStack {
                        Image(systemName: "xmark")
                            .foregroundStyle(.red)
                            .opacity(vm.textFieldText.count < 1 ? 0.0 :
                                        vm.textIsValid ? 0.0 : 1.0)
                        
                        Image(systemName: "checkmark")
                            .foregroundStyle(.green)
                            .opacity(vm.textIsValid ? 1.0 : 0.0)
                        
                    }
                    .font(.title)
                    .padding(.trailing)
                    
                    , alignment: .trailing
                )
            
            Button(action: {}, label: {
                Text("Submit".uppercased())
                    .font(.headline)
                    .foregroundStyle(.white)
                    .frame(height: 55)
                    .frame(maxWidth: .infinity)
                    .background(.blue)
                    .clipShape(.buttonBorder)
                    .opacity(vm.showButton ? 1.0 : 0.5)
                    
            })
            .disabled(!vm.showButton)
        }
        .padding()
    }
}

#Preview {
    SubscriberView()
}
