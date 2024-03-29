//
//  SearchManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 05.02.24.
//

import Foundation

class SearchManager:SearchUseCase {
    func getSearchItems(searchText: String, completion: @escaping ((TrendingModel?, Error?) -> Void)) {
        let url = NetworkHelper.join(endpoint: SearchEndPoint.gif.rawValue) + "&q=\(searchText)"
        NetworkManager.request(model: TrendingModel.self, endpoint: url, completion: completion)
    }
}
