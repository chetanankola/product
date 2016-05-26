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
        print("cell is populated")
        
        let productImage = product?.productImage
        ProductImage.loadImageFromURLString(productImage!, placeholderImage: AppConstants.BLUR_PLACEHOLDER_IMAGE, completion: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
