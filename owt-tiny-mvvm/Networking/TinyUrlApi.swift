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
    func transformUrl(withQuery query: String, completion: @escaping (String) -> ())
}

final class TinyUrlApi : TinyUrlApiService {        
    func transformUrl(withQuery query: String, completion: @escaping (String) -> ()) {        Alamofire.request("http://tinyurl.com/api-create.php?url=https://www.google.com").responseString { response in
        
            completion("test")
        }
    }
}
