//
//  HomePageManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

class TrendingManager:TrendingListUseCase {
    func getTrendingGifList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void)) {
        let url = NetworkHelper.join(endpoint: TrendingEndpoint.trendingGifs.rawValue) + "&offset=\(offsetNumber)"
        NetworkManager.request(model: TrendingModel.self,
                               endpoint: url,
                               completion: completion)
    }
}

