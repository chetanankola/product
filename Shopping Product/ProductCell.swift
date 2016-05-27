//
//  ProductCell.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/26/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit


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
        
        
        if let productImage = product?.productImage {
            //--Product Image---//
            ProductImage.loadImageFromURLString(productImage, placeholderImage: AppConstants.BLUR_PLACEHOLDER_IMAGE, completion: nil)
        }
        
        
        

        if let productShortTitle = product?.shortDescription {
            //---Short Description//
            let str = productShortTitle.stringByReplacingOccurrencesOfString("<.*?>", withString: "", options: .RegularExpressionSearch, range: nil)
            let attrStr = try! NSAttributedString(
                data:  str.dataUsingEncoding(NSUnicodeStringEncoding, allowLossyConversion: true)!,
                options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
                documentAttributes: nil)
            ProductTitle.attributedText = attrStr
        }
        
        
        
        
        
        
        
        

        
        
        
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
