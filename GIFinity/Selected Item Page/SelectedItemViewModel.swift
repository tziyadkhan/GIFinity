//
//  SelectedItemViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import Foundation
class SelectedItemViewModel {
    var trendingGifItems = [TrendingResult]()
    private let manager = SelectedItemManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems() {
        manager.getTrendingGifList() { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage.localizedDescription)
            } else if let data {
                self.trendingGifItems.append(contentsOf: data.data)
                self.success?()
            }
        }
    }
    
}
