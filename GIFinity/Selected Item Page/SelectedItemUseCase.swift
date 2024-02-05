//
//  SelectedItemUseCase.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import Foundation

protocol SelectedItemUseCase {
    func getTrendingGifList(completion: @escaping ((TrendingModel?, Error?) -> Void))
}
