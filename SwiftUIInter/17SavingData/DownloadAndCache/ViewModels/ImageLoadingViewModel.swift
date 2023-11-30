//
//  ImageLoadingViewModel.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 30/11/2023.
//

import Foundation
import SwiftUI

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    let urlString: String
    
    init(url: String) {
        urlString = url
        downloadImage()
    }
    
    func downloadImage() {
        isLoading = true
        guard let url = URL(string: urlString) else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            /* same code as below
            .map { data, response -> UIImage? in
                return UIImage(data: data)
            }
            */
            .map {
                UIImage(data: $0.data)
            }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                self?.image = returnedImage
            }

            
    }
}
