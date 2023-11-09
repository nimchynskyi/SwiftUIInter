//
//  LongPressGesture.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 09/11/2023.
//

import SwiftUI

struct LongPressGestureView: View {
    
    @State var isComplete: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: isComplete ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.gray)
            
            HStack {
                Text("Click here")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(.buttonBorder)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50) { (isPressing) in
                        // start of press -> min duration
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                isComplete = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if !isSuccess {
                                    withAnimation(.easeInOut) {
                                        isComplete = false
                                    }
                                }
                            }
                        }
                    } perform: {
                        // at the min duration (ending action)
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }
                
                Text("Reset")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.black)
                    .clipShape(.buttonBorder)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            isComplete = false
                            isSuccess = false
                        }
                    }
            }
            
        }
        
        
//        Text(isComplete ? "Completed" : "Not Completed" )
//            .padding()
//            .padding(.horizontal)
//            .background(isComplete ? Color.green : Color.red)
//            .cornerRadius(10)
//            .clipShape(.buttonBorder)
////            .onTapGesture {
////                isComplete.toggle()
////            }
//            .onLongPressGesture(minimumDuration: 1.5, maximumDistance: 50) {
//                isComplete.toggle()
//            }
        
    }
}

#Preview {
    LongPressGestureView()
}
