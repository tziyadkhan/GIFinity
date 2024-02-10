//
//  FavouriteModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 10.02.24.
//

import Foundation

struct FavouriteModel: Codable {
    let url: String?
    let size: imageSize?
}

struct imageSize: Codable {
    let height: String?
    let width: String?
}
