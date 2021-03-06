//
//  ProductCell.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/26/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit


class ProductCell: UICollectionViewCell {

    
    @IBOutlet weak var ReviewCount: UILabel!
    @IBOutlet weak var RatingView: RatingStackView!
    @IBOutlet weak var Price: UILabel!
    @IBOutlet weak var ProductName: UILabel!
    @IBOutlet weak var CardView: UIView!
    @IBOutlet weak var ProductImage: UIImageView!
    var product:Product? {
        didSet {
            populateData()
        }
    }
    override func prepareForReuse() {
        ProductImage.image = nil
        super.prepareForReuse()
        
    }
    
    func populateData() {
        if let productImage = product?.productImage {
            //--Product Image---//
            ProductImage.loadImageFromURLString(productImage, placeholderImage: AppConstants.BLUR_PLACEHOLDER_IMAGE, completion: nil)
        }
        if let reviewCount = product?.reviewCount {
            ReviewCount.text = "(\(reviewCount))"
        }
        
        if let reviewRating = product?.reviewRating {
            RatingView.rating = reviewRating
        }
        
        
        if let price = product?.price {
            Price.text = price
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
