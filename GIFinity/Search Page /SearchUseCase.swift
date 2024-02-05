//
//  SearchUseCase.swift
//  GIFinity
//
//  Created by Ziyadkhan on 05.02.24.
//

import Foundation

protocol SearchUseCase {
    func getSearchItems(searchText: String, completion: @escaping ((TrendingModel?, Error?) -> Void))
}
