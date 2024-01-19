//
//  HomePageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

class TrendingPageViewModel {
    var trendingGifItems = [TrendingGifResult]()
    private let manager = TrendingManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems() {
        manager.getTrendingGifList(endpoint: .trendingGifs) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage.localizedDescription)
            } else if let data {
                self.trendingGifItems.append(contentsOf: data.result ?? [])
//                print(data)
                self.success?()
            }
        }
    }
}
