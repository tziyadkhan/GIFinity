//
//  NetworkHelper.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation
import Alamofire

class NetworkHelper {
    static let baseURL = "https://api.giphy.com/v1/"
    static let apiKey = "W9jYxHWzUioIaiXtQ9KzxdVAmiLPt6E5"
    
    static func join(endpoint: String) -> String {
        return ("\(baseURL)\(endpoint)?api_key=\(apiKey)")
    }
}
