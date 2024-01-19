//
//  StickerListUseCase.swift
//  GIFinity
//
//  Created by Ziyadkhan on 19.01.24.
//

import Foundation

protocol StickerListUseCase {
    func getStickerList(offsetNumber: Int, completion: @escaping ((TrendingModel?, Error?) -> Void))
}
