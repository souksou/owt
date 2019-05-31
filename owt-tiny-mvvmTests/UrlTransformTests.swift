//
//  UrlTransformTests.swift
//  owt-tiny-mvvmTests
//
//  Created by Souksouvanh Thomas on 31/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import XCTest
@testable import owt_tiny_mvvm

class UrlTransformTests: XCTestCase {
    
    var viewModel : CreateTinyUrlViewModel!
    var service : TinyUrlApiService!
    
    override func setUp() {
        super.setUp()
         self.service = TinyUrlApi()
         self.viewModel = CreateTinyUrlViewModel(networkingService: self.service)
    }
    
    override func tearDown() {
        self.viewModel = nil
        self.service = nil
        super.tearDown()
    }
    
    func testTransformUrl() {
        let expectation = XCTestExpectation(description: "Verify Transfrom Url")
        
        // expected to not be able to fetch currencies
        viewModel.hasError = { error in
             XCTAssert(false, error)
        }
        
        viewModel.didTransformUrl = { transformUrl in            
            expectation.fulfill()
        }
        
        viewModel.transformUrl("www.google.fr")
        
        wait(for: [expectation], timeout: 5.0)
    }
    

}
