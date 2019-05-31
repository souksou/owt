//
//  Error.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 31/05/2019.
//  Copyright © 2019 th. All rights reserved.
//
import Foundation

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

