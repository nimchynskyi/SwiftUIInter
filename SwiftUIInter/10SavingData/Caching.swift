//
//  Caching.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 26/11/2023.
//

import SwiftUI

class CacheManager {
    
    static let instance = CacheManager() // Singleton
    private init() {} // to not let create other manager as this is a Singleton
    
    var imageCache: NSCache<NSString, UIImage> = {
        let cache = NSCache<NSString, UIImage>()
        cache.countLimit = 100 // limit max number of items stored, try to keep as low as possible
        cache.totalCostLimit = 1024 * 1024 * 100 // 100mb
        
        return cache
    }()
    
    func add(image: UIImage, name: String) -> String{
        imageCache.setObject(image, forKey: name as NSString)
        return "Added to cache!"
    }
    
    func remove(name: String) -> String{
        imageCache.removeObject(forKey: name as NSString)
        return "Removed from cache!"
    }
    
    func get(name: String) -> UIImage? {
        return imageCache.object(forKey: name as NSString)
    }
}

class CachingViewModel: ObservableObject {
    
    @Published var startingImage: UIImage? = nil
    @Published var cachedImage: UIImage? = nil
    @Published var infoMessage: String = ""
    
    let imageName: String = "iphone-xr-in-hand"
    let manager = CacheManager.instance
    
    init() {
        getImageAssetsFolder()
    }
    
    func getImageAssetsFolder() {
        startingImage = UIImage(named: imageName)
    }
    
    func saveToCache() {
        guard let image = startingImage else { return }
        infoMessage = manager.add(image: image, name: imageName)
    }
    
    func removeFromCache() {
        infoMessage = manager.remove(name: imageName)
    }
    
    func getFromCache() {
        
        if let returnedImage = manager.get(name: imageName) {
            cachedImage = returnedImage
            infoMessage = "Got image from Cache"
        } else {
            infoMessage = "Image not found in Cache"
        }
    }
}

struct Caching: View {
    
    @StateObject var vm = CachingViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                if let image = vm.startingImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                Text(vm.infoMessage)
                    .font(.headline)
                    .foregroundStyle(.purple)
                
                HStack {
                    Button(action: {
                        vm.saveToCache()
                    }, label: {
                        Text("Save to cache")
                            .font(.headline.bold())
                            .foregroundStyle(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.blue)
                            .clipShape(.buttonBorder)
                    })
                    
                    Button(action: {
                        vm.removeFromCache()
                    }, label: {
                        Text("Delete from cache")
                            .font(.headline.bold())
                            .foregroundStyle(.white)
                            .frame(height: 60)
                            .frame(maxWidth: .infinity)
                            .background(.red)
                            .clipShape(.buttonBorder)
                    })
                }
                .padding(.horizontal, 20)
                
                Button(action: {
                    vm.getFromCache()
                }, label: {
                    Text("Get from cache")
                        .font(.headline.bold())
                        .foregroundColor(.green)
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(.green.opacity(0.3))
                        .clipShape(.buttonBorder)
                        .padding(.horizontal, 20)
                })
                
                if let image = vm.cachedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                Spacer()
            }
            .navigationTitle("Caching images")
        }
    }
}

#Preview {
    Caching()
}
