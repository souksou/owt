//
//  TinyUrlApi.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit
import Alamofire

protocol TinyUrlApiService {
    func transformUrl(withQuery query: String, completion: @escaping (String, Bool) -> ())
}

final class TinyUrlApi : TinyUrlApiService {        
    func transformUrl(withQuery query: String, completion: @escaping (String, Bool) -> ()) {        Alamofire.request("\(Constants.baseUrl)\(Constants.createEndpoint)\(query)").responseString { response in
            if let data = response.data {
                completion(String(data: data, encoding: .utf8)!, true)
            } else {
                completion("", false)
            }
        }
    }
}
