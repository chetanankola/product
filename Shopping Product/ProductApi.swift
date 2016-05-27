//
//  ProductApi.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/25/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import Foundation
import SwiftyJSON


class ProductApi {
    
    static let sharedInstance = ProductApi()
    
    func getUrl(pageNum:Int) -> NSURL {
        let urlString = AppConstants.ROOT_PRODUCT_URL + AppConstants.PRODUCT_URL_PATH + String(pageNum) + "/" + String(AppConstants.MAX_PAGE_SIZE)
        print(urlString)
        return NSURL(string: urlString)!
    }
    
    
    func handleError(error:AnyObject, completionHandler: (jsonData: JSON?, success:Bool, errorMessage: String? ) -> Void) {
        if error.domain == NSURLErrorDomain && error.code == NSURLErrorNotConnectedToInternet {
            completionHandler(jsonData: nil, success: false, errorMessage: "The Internet connection appears to be offline." )
        } else if error.domain == NSURLErrorDomain && error.code == NSURLErrorTimedOut {
            completionHandler(jsonData: nil, success: false, errorMessage: "Oops! The service timed out. Please try again after some time.")
        } else {
            completionHandler(jsonData: nil, success: false, errorMessage: error.description)
        }
        
    }
    
    func getProductList(pageNum:Int, completionHandler: (jsonData: JSON?, success:Bool, errorMessage: String? ) -> Void) {

        
        let url = getUrl(pageNum)
        let task = NSURLSession.sharedSession().dataTaskWithURL(url, completionHandler: {data, response, error -> Void in
            if error != nil {
                self.handleError(error!, completionHandler:completionHandler)
            } else {
                
                
//                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                if let dataFromString = dataString!.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
//                    let json = JSON(data: dataFromString)
//                    completionHandler(jsonData: json, success: true, errorMessage: nil)
//                }

                
//                let encodedData = encodedString.dataUsingEncoding(NSUTF8StringEncoding)!
//                let attributedOptions : [String: AnyObject] = [
//                    NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
//                    NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
//                ]
//                print(data)
//                let resstr = NSString(data: data!, encoding: NSUTF8StringEncoding)
//                print(resstr)
                let json = JSON(data: data!)
                completionHandler(jsonData: json, success: true, errorMessage: nil)
            }
        })

        task.resume()
    }
}