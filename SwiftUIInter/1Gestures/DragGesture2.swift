//
//  DragGesture2.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 09/11/2023.
//

import SwiftUI

struct DragGestureView2: View {
    
    @State var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.75
    @State var currentDragOffsetY: CGFloat = 0
    @State var endingOffsetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            SignUpView()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffsetY)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        }
                        .onEnded { value in
                            
                            withAnimation(.spring()) {
                                if currentDragOffsetY < -200 {
                                    endingOffsetY = -startingOffsetY
                                    currentDragOffsetY = 0
                                } else if endingOffsetY != 0 && currentDragOffsetY > 250 {
                                    endingOffsetY = 0
                                    currentDragOffsetY = 0
                                }
                                currentDragOffsetY = 0
                            }
                        }
                )
            Text("\(currentDragOffsetY)")
                .foregroundStyle(.red)
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

#Preview {
    DragGestureView2()
}

struct SignUpView: View {
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign Up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("This is description! Use clipShape(_:style:) to clip the view to the provided shape. By applying a clipping shape to a view, you preserve the parts of the view covered by the shape, while eliminating other parts of the view. The clipping shape itself isn’t visible.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Text("Create an account")
                .foregroundStyle(.background)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(.primary)
                .clipShape(.capsule)
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(.background)
        .clipShape(.rect(cornerRadius: 30))
    }
}
