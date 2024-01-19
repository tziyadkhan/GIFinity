//
//  HomePageManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

class TrendingManager:TrendingListUseCase {
    func getTrendingGifList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void)) {
        let url = TrendingEndpoint.trendingGifs.rawValue
        NetworkManager.request(model: TrendingModel.self, 
                               endpoint: url,
                               offsetNumber: offsetNumber,
                               completion: completion)
    }
}
