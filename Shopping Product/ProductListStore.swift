//
//  ProductListStore.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/25/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import Foundation
import Signals

class ProductListStore {
    
    private static var totalProducts: Int = 0
    private static var pageNum: Int = AppConstants.INITIAL_PAGE_NUMBER
    private static var ProductList: [Product] = [] {
        didSet {
            //may be or may not a good idea to fire here
        }
    }
    
    
    class func getProductList() -> [Product] {
        return ProductList
    }
    
    //Signals
    static let ProductListUpdated = Signal<[Product]>()
    
    
    static func initStore() {
        getNextPage()
    }
    
    static func getNextPage() {
        ProductApi.sharedInstance.getProductList(pageNum) { (jsonData, success, errorMessage) in
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (success) {
                    let data = jsonData!
                    print("got data")
                    
                    if let items = data["products"].array {
                        for item in items { ProductList.append(Product(jsonData: item)) }
                        
                        pageNum = data["pageNumber"].intValue
                        totalProducts = data["totalProducts"].intValue
                        
                        pageNum = pageNum + 1
                        
                        //let all listeners know about new products
                        //better to fire here than on didSet
                        ProductListUpdated.fire(ProductList)
                    } else {
                        //better handling?
                        print(data["error"]["message"])
                    }
    //                print(data)
                } else {
                    print(errorMessage)
                }
            })
        }

    }
}