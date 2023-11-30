//
//  DownloadImageViewModel.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 27/11/2023.
//

import Foundation
import Combine

class DownloadImageViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    // can ref dataService and put in its cancellables but much better to separate
    var cancellables = Set<AnyCancellable>()
    
    let dataService = PhotoModelDataService.instance
    
    init() {
        addSubscribers()
    }
    
    // bc photoModels array is a publisher - i can subscribe to it to cont get publish values
    
    func addSubscribers() {
        // $ is important here bc its a publisher
        dataService.$photoModels
            .sink { [weak self] returnedPhotoModels in
                self?.dataArray = returnedPhotoModels
            }
            .store(in: &cancellables)
    }
}
