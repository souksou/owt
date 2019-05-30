//
//  TinyUrl.swift
//  owt-tiny-mvvm
//
//  Created by Souksouvanh Thomas on 30/05/2019.
//  Copyright © 2019 th. All rights reserved.
//

import UIKit
import RealmSwift

class TinyUrl: Object {
    @objc dynamic var originalUrl  = ""
    @objc dynamic var urlTransform = ""
    @objc dynamic var dateCreate: Date?
}



