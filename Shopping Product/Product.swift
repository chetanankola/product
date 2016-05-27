//
//  Product.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/25/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import Foundation
import SwiftyJSON

class Product {
    
    var productId:String!
    
    //optionals
    var name:String?
    var reviewCount: Int?
    var productImage: String?
    var price:String?
    var longDescription: String?
    var shortDescription: String?
    var reviewRating: Double?
    var inStock: Bool?
    
    init (jsonData:JSON) {
        self.productId          = jsonData["productId"].stringValue
        //optionals
        self.name               = jsonData["name"].stringValue
        self.reviewCount        = jsonData["reviewCount"].intValue
        self.productImage       = jsonData["productImage"].stringValue
        self.price              = jsonData["price"].stringValue
        self.longDescription    = jsonData["longDescription"].stringValue
        self.shortDescription    = jsonData["shortDescription"].stringValue
        self.reviewRating       = jsonData["reviewRating"].doubleValue
        self.inStock            = jsonData["inStock"].boolValue
    
    }
}