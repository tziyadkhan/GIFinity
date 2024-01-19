//
//  StickerPageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import Foundation
class StickerPageViewModel {
    var stickerItems = [TrendingResult]()
    private let manager = StickerManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems() {
        manager.getStickerList(offsetNumber: 50) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage.localizedDescription)
            } else if let data {
                self.stickerItems.append(contentsOf: data.result ?? [])
                self.success?()
            }
        }
    }
}
