//
//  HomeViewModel.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import Foundation

class HomeViewModel {
    // Outputs
    var isRefreshing: ((Bool) -> Void)?
    var didUpdateTiny: (([TinyUrl]) -> Void)?
    
    private var lastQuery: String?
    private(set) var tinyUrls: [TinyUrl] = [TinyUrl]() {
        didSet {
            didUpdateTiny?(tinyUrls)
        }
    }
    
    // Dependencies
    private let networkingService: TinyUrlApiService
    
    init(networkingService: TinyUrlApiService) {
        self.networkingService = networkingService
    }
    
    // Inputs
    func ready() {
        isRefreshing?(true)
        self.fetchTinyUrls()
    }
    
    func deleteUrl(_ tiny: TinyUrl) {
        if tinyUrls.isEmpty { return }
        DatabaseManager.shared.delete(object: tiny)
        self.fetchTinyUrls()
    }
   
    
    func didChangeQuery(_ query: String) {
        guard query.count > 2,
            query != lastQuery else { return }
        lastQuery = query

        self.startSearchWithQuery(query)
    }
    
    // Private
    private func fetchTinyUrls() {
        isRefreshing?(true)
        
        let tinyUrls = DatabaseManager.shared.fetchTinyUrl()
        self.finishSearching(with: tinyUrls)
    }
    
    private func startSearchWithQuery(_ query: String) {
        isRefreshing?(true)
        
        let tinyUrls = DatabaseManager.shared.searchTinyUrl(query: query.lowercased())
        self.finishSearching(with: tinyUrls)
    }

    private func finishSearching(with tinyUrls: [TinyUrl]) {
        isRefreshing?(false)
        self.tinyUrls = tinyUrls
    }
}
