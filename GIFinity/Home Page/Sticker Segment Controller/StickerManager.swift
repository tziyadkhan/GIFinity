//
//  StickerManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import Foundation

class StickerManager: StickerListUseCase {
    func getStickerList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void)) {
        let url = StickerEndpoint.sticker.rawValue
        let param: [String: Any] = ["offset": offsetNumber]
        NetworkManager.request(model: TrendingModel.self,
                               endpoint: url,
                               parameters: param,
                               completion: completion)
    }
}
