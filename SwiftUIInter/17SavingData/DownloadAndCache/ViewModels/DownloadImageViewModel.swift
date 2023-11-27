//
//  DownloadImageViewModel.swift
//  SwiftUIInter
//
//  Created by Dmytro Nimchynskyi on 27/11/2023.
//

import Foundation

class DownloadImageViewModel: ObservableObject {
    
    @Published var dataArray: [PhotoModel] = []
    
    let dataService = PhotoModelDataService.instance
    
}
