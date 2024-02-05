//
//  SelectedItemManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import Foundation

class SelectedItemManager:SelectedItemUseCase {
    func getTrendingGifList(completion: @escaping ((TrendingModel?, Error?) -> Void)) {
        let url = NetworkHelper.join(endpoint: TrendingEndpoint.trendingGifs.rawValue)
        NetworkManager.request(model: TrendingModel.self,
                               endpoint: url,
                               completion: completion)
    }
}
