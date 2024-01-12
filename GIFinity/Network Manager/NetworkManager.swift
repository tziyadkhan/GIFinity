//
//  NetworkManager.swift
//  GIFinity
//
//  Created by Ziyadkhan on 12.01.24.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static func request<T: Codable>(model: T.Type,
                                    endpoint: String,
                                    method: HTTPMethod = .get,
                                    parameters: Parameters? = nil,
                                    encoding: ParameterEncoding = URLEncoding.default, 
                                    header: HTTPHeaders? = nil,
                                    completion: @escaping (T?, Error?) -> Void) {
        AF.request("\(NetworkHelper.baseURL)\(endpoint)?api_key=\(NetworkHelper.apiKey)",
                   // api.giphy.com/v1/gifs/trending?api_key=W9jYxHWzUioIaiXtQ9KzxdVAmiLPt6E5
                   method: method,
                   parameters: parameters,
                   encoding: encoding,
                   headers: header).responseDecodable(of: T.self) { response in
            switch (response.result) {
                
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
    }
}
