//
//  HomePageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

class TrendingPageViewModel {
    var trendingGifItems = [TrendingResult]()
    private let manager = TrendingManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems() {
        manager.getTrendingGifList(offsetNumber: 100) { data, errorMessage in
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

 // 1 page'de 50 dene item yerleshir, yeni 1 page 0-50 offset, ikinci page ucun +50 yeni 50-den 100-e qeder.
