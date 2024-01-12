//
//  HomePageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

class HomePageViewModel {
    var trendingGifItems = [TrendingGifResults]()
    private let manager = HomeManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems() {
        manager.getTrendingGifList(endpoint: .trendingGifs) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage.localizedDescription)
            } else if let data {
                self.trendingGifItems.append(contentsOf: data.result ?? [])
//                print(data.result ?? ["nil"])
                self.success?()
            }
        }
    }
}
