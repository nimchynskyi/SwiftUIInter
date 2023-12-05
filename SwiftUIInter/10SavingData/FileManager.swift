//
//  FileManager.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 24/11/2023.
//

import SwiftUI

class LocalFileManager {
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName)
                .path else {
            return
        }
        
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("Success creating folder.")
            } catch let error {
                print("Error creating folder. \(error)")
            }
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName)
                .path else {
            return
        }
        do {
            try FileManager.default.removeItem(atPath: path)
            print("Success deleting folder.")
        } catch let error {
            print("Error deleting folder. \(error)")
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard
            let data = image.jpegData(compressionQuality: 1.0),
            let path = getPathForImage(name: name) else {
            return "Error getting data."
        }
        
        do {
            try data.write(to: path)
            print(path)
            return "Success saving!"
        } catch let error {
            return "Error saving. \(error)"
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
    
    func deleteImage(name: String) -> String {
        guard
            let path = getPathForImage(name: name)?.path,
            FileManager.default.fileExists(atPath: path) else {
            return "Error getting path."
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
            return "Successfully deleted"
        } catch let error {
            return "Error deleting image. \(error)"
        }
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appending(path: folderName) // DONT FORGET TO ADD DIRECTORY IF NEEDED BEFORE ACTUAL IMAGE
                .appending(path: "\(name).jpg") else {
            print("Error getting path.")
            return nil
        }
        
        return path
    }
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var infoMessage: String = ""
    
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
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
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
                
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to FileManager")
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                    }
                    .buttonStyle(.borderedProminent)
                    
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from FileManager")
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                    }
                    .buttonStyle(.bordered)
                    .tint(.red)
                }
                
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundStyle(.purple)
                
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

#Preview {
    FileManagerView()
}
