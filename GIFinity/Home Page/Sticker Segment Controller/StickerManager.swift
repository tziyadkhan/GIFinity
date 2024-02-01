//
//  StickerManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import Foundation

class StickerManager: StickerListUseCase {
    func getStickerList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void)) {
        let url = NetworkHelper.join(endpoint: StickerEndpoint.sticker.rawValue) + "&offset=\(offsetNumber)"
        NetworkManager.request(model: TrendingModel.self,
                               endpoint: url,
                               completion: completion)
    }
}

