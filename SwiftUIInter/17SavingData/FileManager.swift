//
//  FileManager.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 24/11/2023.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        
        guard 
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            print("Error getting data.")
            return
        }
        
        do {
            try data.write(to: path)
            print("Success saving!")
        } catch let error {
            print("Error saving. \(error)")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            print("Error getting path.")
            return nil
        }
        
        return UIImage(contentsOfFile: path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: "\(name).jpg") else {
            print("Error getting path.")
            return nil
        }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    let imageName: String = "iphone-xr-in-hand"
    let manager = LocalFileManager.instance
    
    init() {
        getImageFromAssetsFolder()
//        getImageFromFileManager()
    }
    
    func getImageFromAssetsFolder() {
        image = UIImage(named: imageName)
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func saveImage() {
        guard let image = image else { return }
        manager.saveImage(image: image, name: imageName)
    }
}

struct FileManagerView: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                Button {
                    vm.saveImage()
                } label: {
                    Text("Save to FileManager")
                        .font(.headline)
                        .padding()
                }
                .buttonStyle(.borderedProminent)

                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerView()
}
