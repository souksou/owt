//
//  owt_tiny_mvvmTests.swift
//  owt-tiny-mvvmTests
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import XCTest
@testable import owt_tiny_mvvm

class ServiceApiTests: XCTestCase {


    var sut: URLSession!
    
    override func setUp() {
        super.setUp()
        sut = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    
    func testValidCallToTinyGetsHTTPStatusCode200() {
 
        let url = URL(string: "http://tinyurl.com/api-create.php?url=https://www.google.com")
        let promise = expectation(description: "Status code: 200")

        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            } else if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                if statusCode == 200 {
                    promise.fulfill()
                } else {
                    XCTFail("Status code: \(statusCode)")
                }
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }
    
    func testTinyValidUrl() {
        let url = URL(string: "http://tinyurl.com/api-create.php?url=https://www.google.com")
        let promise = expectation(description: "Return correct Tiny Url")
        
        let dataTask = sut.dataTask(with: url!) { data, response, error in
            if let error = error {
                XCTFail("Error: \(error.localizedDescription)")
                return
            }
            
            if data == nil {
                XCTFail("no data")
                return
            }
            
            let result = String(data: data!, encoding: .utf8)
            if (result?.contains("http://tinyurl.com/"))! {
                promise.fulfill()
            } else {
                XCTFail("Url no valid")
            }
        }
        dataTask.resume()
        
        wait(for: [promise], timeout: 5)
    }

}
