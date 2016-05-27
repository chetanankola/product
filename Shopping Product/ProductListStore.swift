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
    private static var currentPageBeingFetched: Int = -1
    private static var ProductList: [Product] = [] {
        didSet {
            //may be or may not a good idea to fire here
        }
    }
    
    
    class func findProduct(product:Product) -> Int? {
        return ProductList.indexOf({ $0 === product})
    }
    
    class func getProductList() -> [Product] {
        return ProductList
    }
    
    //Signals
    static let ProductListUpdated = Signal<(productList:[Product], diffProductList:[Product])>()
    
    
    static func initStore() {
        getNextPage()
    }
    
    static func getNextPage() {
        
        
        
        if (currentPageBeingFetched == pageNum) {
//            print("return! same page being fetched \(currentPageBeingFetched)")
            return
        }
        currentPageBeingFetched = pageNum
        print("Fetching data for page:\(pageNum)")
        ProductApi.sharedInstance.getProductList(pageNum) { (jsonData, success, errorMessage) in
            
            
            //do not append same pagenum data into prod
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                if (success) {
                    let data = jsonData!
//                    print("Success! Fetched page:\(pageNum)")
                    
                    if let items = data["products"].array {
                        var diffArray = [Product]()
                        for item in items {
                            let productItem = Product(jsonData: item)
                            ProductList.append(productItem)
                            diffArray.append(productItem)
                        }
                        print("total items: \(ProductList.count)")
                        pageNum = data["pageNumber"].intValue
                        totalProducts = data["totalProducts"].intValue
                        
                        pageNum = pageNum + 1
                        
                        //let all listeners know about new products
                        //better to fire here than on didSet
                        ProductListUpdated.fire((productList:ProductList, diffProductList:diffArray))
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