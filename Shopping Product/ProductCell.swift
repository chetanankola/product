//
//  ProductCell.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/26/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit

//extension String {

//    var html2AttributedString: NSAttributedString? {
//        guard
//            let data = dataUsingEncoding(NSUTF8StringEncoding)
//            else { return nil }
//        do {
//            return try NSAttributedString(data: data, options: [NSDocumentTypeDocumentAttribute:NSHTMLTextDocumentType,NSCharacterEncodingDocumentAttribute:NSUTF8StringEncoding], documentAttributes: nil)
//        } catch let error as NSError {
//            print(error.localizedDescription)
//            return  nil
//        }
//    }
//    var html2String: String {
//        return html2AttributedString?.string ?? ""
//    }
//}


class ProductCell: UICollectionViewCell {

    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var ProductTitle: UILabel!
    @IBOutlet weak var ProductImage: UIImageView!
    var product:Product? {
        didSet {
            populateData()
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    func populateData() {
        
        
        let productImage = product?.productImage
        let productShortTitle = product?.shortDescription//!.html2String
        
        
        
        
        ProductImage.loadImageFromURLString(productImage!, placeholderImage: AppConstants.BLUR_PLACEHOLDER_IMAGE, completion: nil)
        
        
        
//        var str = productShortTitle!.stringByReplacingOccurrencesOfString("<[^>]+>", withString: "", options: .RegularExpressionSearch, range: nil)
        var str = productShortTitle!.stringByReplacingOccurrencesOfString("<.*?>", withString: "", options: .RegularExpressionSearch, range: nil)
        if (str.isEmpty) {
            str = "No Title"
        }
        let attrStr = try! NSAttributedString(
            data:  str.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
        ProductTitle.attributedText = attrStr
//        ProductTitle.text = str
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
