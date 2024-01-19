//
//  HomePageUseCase.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation

protocol TrendingListUseCase {
    func getTrendingGifList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void))
}
