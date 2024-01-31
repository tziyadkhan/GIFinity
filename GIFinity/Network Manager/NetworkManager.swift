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
                                    completion: @escaping (T?, Error?) -> Void) {
        
        var apiParam = parameters ?? [:]
        apiParam["api_key"] = NetworkHelper.apiKey
        AF.request("\(NetworkHelper.baseURL)\(endpoint)",
                   method: method,
                   parameters: apiParam,
                   encoding: encoding).responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let data):
                completion(data, nil)
            case .failure(let error):
                completion(nil, error)
            }
        }
        print("\(NetworkHelper.baseURL)\(endpoint)")

    }
}
