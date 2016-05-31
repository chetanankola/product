//
//  ProductDetailCell.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/27/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {

    
    
    
    @IBOutlet weak var InStock: UILabel!
    @IBOutlet weak var ReviewCount: UILabel!
    @IBOutlet weak var ProductPrice: UILabel!
    @IBOutlet weak var RatingView: RatingStackView!
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var ShortDescription: UILabel!
    @IBOutlet weak var LongDescription: UILabel!
    
    
    
    
    
    var product: Product? {
        didSet {
            populateData()
        }
    }
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    
    func populateData() {
        if let productImage = product?.productImage {
            //--Product Image---//
            ProductImage.loadImageFromURLString(productImage, placeholderImage: AppConstants.BLUR_PLACEHOLDER_IMAGE, completion: nil)
        }
        if let productName = product?.productName {
                ProductName.text = productName
        }
        
        if let inStock = product?.inStock {
            InStock.text = "In Stock:" + (inStock ? "Yes" : "No")
        }
        
        if let reviewCount = product?.reviewCount {
            ReviewCount.text = "\(reviewCount) review" + (reviewCount != 1 ? "s" : "")
        }
        
        
        if let reviewRating = product?.reviewRating {
            RatingView.rating = reviewRating
        }
        
        
        if let price = product?.price {
            ProductPrice.text = price
        }
        
        if let productShortDescription = product?.shortDescription {
            //---Short Description//
            let str = productShortDescription.stringByReplacingOccurrencesOfString("<.*?>", withString: "", options: .RegularExpressionSearch, range: nil)
            let attrStr = try! NSAttributedString(
                data:  str.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
//            ShortDescription.attributedText = attrStr.string
            ShortDescription.text = attrStr.string
        }
        
        if let productLongDescription = product?.longDescription {
            //---Short Description//
            let str = productLongDescription.stringByReplacingOccurrencesOfString("<.*?>", withString: "", options: .RegularExpressionSearch, range: nil)
            let attrStr = try! NSAttributedString(
                data:  str.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            LongDescription.text = attrStr.string
        }
        
        
 
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
