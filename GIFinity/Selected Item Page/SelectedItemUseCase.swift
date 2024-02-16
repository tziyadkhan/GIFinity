//
//  SelectedItemUseCase.swift
//  GIFinity
//
//  Created by Ziyadkhan on 03.02.24.
//

import Foundation

protocol SelectedItemUseCase {
    func getTrendingGifList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void))
}
