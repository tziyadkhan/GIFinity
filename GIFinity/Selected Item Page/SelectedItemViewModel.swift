//
//  SelectedItemViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import Foundation
import Photos

class SelectedItemViewModel {
    
    var trendingGifItems = [TrendingResult]()
    private let manager = SelectedItemManager()
    var success: (() -> Void)?
    var error: ((String?) -> Void)?
    
    //Other GIF's ucun random offset
    func getItems() {
        manager.getTrendingGifList(offsetNumber: Int.random(in: 0..<1400)) { data, errorMessage in
            if let errorMessage {
                self.error?(errorMessage.localizedDescription)
            } else if let data {
                self.trendingGifItems.append(contentsOf: data.data)
                self.success?()
            }
        }
    }
    
    func reset() {
        trendingGifItems.removeAll()
    }
    
    func saveGifToPhotosHelper(gifData: Data) {
        PHPhotoLibrary.shared().performChanges {
            let creationRequest = PHAssetCreationRequest.forAsset()
            creationRequest.addResource(with: .photo, data: gifData, options: nil)
        } completionHandler: { success, error in
            if success {
                print("GIF saved successfully.")
            } else if let error = error {
                print("Error saving GIF: \(error.localizedDescription)")
            }
        }
    }
}
