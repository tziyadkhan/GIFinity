//
//  SearchPageViewModel.swift
//  GIFinity
//
//  Created by Ziyadkhan on 05.02.24.
//

import Foundation

class SearchPageViewModel {
    
    var searchedGifItem = [TrendingResult]()
    var success: (() -> Void)?
    var error: ((String) -> Void)?
    private let manager = SearchManager()
    
    func getSearchItem(searchText: String, completion: @escaping () -> Void) {
        manager.getSearchItems(searchText: searchText) { data, error in
            if let error {
                print("test error-")
                self.error?(error.localizedDescription)
            } else if let data {
                print("test success+")
                self.searchedGifItem = data.data
                self.success?()
                completion()
            }
        }
    }
    
    func clearItems() {
        searchedGifItem.removeAll()
    }
}
