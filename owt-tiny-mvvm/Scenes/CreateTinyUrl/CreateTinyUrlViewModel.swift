//
//  CreateTinyUrlViewModel.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import Foundation
import UIKit

class CreateTinyUrlViewModel {
    
    // outputs
    var isRefreshing: ((Bool) -> Void)?
    var hasError: ((String) -> Void)?
    var didTransformUrl: ((Bool) -> Void)?
    
    private var lastUrl: String?
    
    // Dependencies
    private let networkingService: TinyUrlApiService
    
    init(networkingService: TinyUrlApiService) {
        self.networkingService = networkingService
    }
    
    // Inputs
    func ready() {
        isRefreshing?(true)
    }
    
    func transformUrl(_ url: String) {
         isRefreshing?(true)
        var urlFinal = url
        
        if(!url.contains("https://") && !url.contains("http://")) {
            urlFinal = "https://\(url)"
        }
        
        if !urlFinal.isValidURL() {
            self.finishTransform()
            hasError?("Not a valid URL")
            return
        }
        
        networkingService.transformUrl(withQuery: urlFinal) {[weak self] dataResult in
            guard let strongSelf  = self else { return }
            switch dataResult {
            case .success(let urlTransform) :
                let tiny = TinyUrl()
                tiny.originalUrl = url
                tiny.urlTransform = urlTransform
                tiny.dateCreate = Date()
                DatabaseManager.shared.add(tinyUrls: tiny)
                
                UIPasteboard.general.string = urlTransform
                
                strongSelf.finishTransform()
                strongSelf.didTransformUrl?(true)
                break
            case .failure(let error) :
                debugPrint("error \(error)")
                strongSelf.finishTransform()
                strongSelf.hasError?("Error")
                break
            }
        }
        
//        networkingService.transformUrl(withQuery: urlFinal) { [weak self] (urlTransform, success) in
//
//            guard let strongSelf  = self else { return }
//
//            if success {
//                // create Tiny and save
//                let tiny = TinyUrl()
//                tiny.originalUrl = url
//                tiny.urlTransform = urlTransform
//                tiny.dateCreate = Date()
//                DatabaseManager.shared.add(tinyUrls: tiny)
//
//                UIPasteboard.general.string = urlTransform
//
//                strongSelf.finishTransform()
//                strongSelf.didTransformUrl?(true)
//            } else {
//                 strongSelf.finishTransform()
//                 strongSelf.hasError?("Error with the script")
//            }
//        }
    }
    
    private func finishTransform() {
        isRefreshing?(false)  
    }
}
