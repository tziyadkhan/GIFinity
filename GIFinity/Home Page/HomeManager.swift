//
//  HomePageManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

class HomeManager:TrendingListUseCase {
    func getTrendingGifList(endpoint: HomePageEndPoint, completion: @escaping ((TrendingGifModel?, Error?) -> Void)) {
        NetworkManager.request(model: TrendingGifModel.self, endpoint: endpoint.rawValue, completion: completion)
    }
}
