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
    // Next step set a Result Type 
    func transformUrl(withQuery query: String, completion: @escaping (Result<String, ErrorResult>) -> ())
}

final class TinyUrlApi : TinyUrlApiService {        
    func transformUrl(withQuery query: String, completion: @escaping (Result<String, ErrorResult>) -> ()) {        Alamofire.request("\(Constants.baseUrl)\(Constants.createEndpoint)\(query)").responseString { response in
            if let data = response.data {
               // completion(String(data: data, encoding: .utf8)!, true)
                completion(.success(String(data: data, encoding: .utf8)!))
            } else {
                completion(.failure(.custom(string: "No data")))
            }
        }
    }
}
