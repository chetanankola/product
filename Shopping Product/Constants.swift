//
//  Constants.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/25/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import Foundation
import UIKit

struct AppConstants {
    static let API_KEY = "65f87a4f-494a-4d43-a35e-c3966b92684d"
    static let ROOT_PRODUCT_URL = "https://walmartlabs-test.appspot.com/_ah/api/walmart/v1/"
    static let MAX_PAGE_SIZE = 10
    static let INITIAL_PAGE_NUMBER = 1
    static let PRODUCT_URL_PATH = "walmartproducts/" + API_KEY + "/"
    
    static let BLUR_PLACEHOLDER_IMAGE = UIImage(named: "blurImage")
    static let IPHONE_6_WIDTH = CGFloat(375)
}

