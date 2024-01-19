//
//  HomePageUseCase.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

protocol TrendingListUseCase {
    func getTrendingGifList(endpoint: TrendingEndpoint, completion: @escaping ((TrendingGifModel?, Error?) -> Void))
}
