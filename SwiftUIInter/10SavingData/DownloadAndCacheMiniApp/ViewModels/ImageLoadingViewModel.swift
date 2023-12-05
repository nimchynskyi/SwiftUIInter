//
//  ImageLoadingViewModel.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 30/11/2023.
//

import Foundation
import SwiftUI
import Combine

class ImageLoadingViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var isLoading: Bool = false
    
    var cancellables = Set<AnyCancellable>()
    
    // FileManager is much more memory efficient ~50mb vs ~250mb using cache manager
    // However, while using FileManager saves data on device and takes space
    // Need to use it sparingly, e.g. user account photos, apps main page images etc.
    
    // let manager = PhotoModelCacheManager.instance
    let manager = PhotoModelFileManager.instance
    
    let urlString: String
    let imageKey: String
    
    init(url: String, key: String) {
        urlString = url
        imageKey = key
        // downloadImage() // instead of calling this, call getImage which includes downloadImage in case image is not cached
        getImage()
    }
    
    func getImage() {
        if let savedImage = manager.get(key: imageKey) {
            image = savedImage
            print("Getting saved image!")
        } else {
            downloadImage()
            print("Downloading image now!")
        }
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
            .map { UIImage(data: $0.data) }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.isLoading = false
            } receiveValue: { [weak self] returnedImage in
                guard 
                    let self = self,
                    let image = returnedImage else { return }
                
                self.image = image
                self.manager.add(key: self.imageKey, value: image) // adding to cache
            }
            .store(in: &cancellables)
    }
}
