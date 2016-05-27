//
//  ProductDetailCell.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/27/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit

class ProductDetailCell: UICollectionViewCell {

    
    
    
    @IBOutlet weak var ProductImage: UIImageView!
    @IBOutlet weak var ProductName: UILabel!
    
    
    
    
    
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
 
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
