//
//  StickerPageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import Foundation
class StickerPageViewModel {
    var stickerItems = [TrendingResult]()
    var stickerData: TrendingModel?
    private let manager = StickerManager()
    
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    func getItems() {
        manager.getStickerList(offsetNumber: (stickerData?.pagination?.offset ?? 0) + 50) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage.localizedDescription)
            } else if let data {
                self.stickerData = data
                self.stickerItems.append(contentsOf: data.result ?? [])
                self.success?()
            }
        }
    }
    func pagination(index: Int) {
        if index == stickerItems.count - 2 &&
            stickerData?.pagination?.count ?? 0 <= stickerData?.pagination?.totalCount ?? 0 {
            getItems()
        }
    }
}
