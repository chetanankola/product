//
//  RatingStackView.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/31/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit
import FontAwesome_swift

class RatingStackView: UIStackView {
    
    var rating:Double = 0.0 {
        didSet {
            setView()
        }
    }
    
    var stack:UIStackView = UIStackView()
    
    required init?(coder aDecoder: NSCoder) {
        
        super.init(coder: aDecoder)
        
        self.axis = .Horizontal
        self.distribution = .FillProportionally
        
    }
    
    func setView() {
        self.subviews.forEach {$0.removeFromSuperview()}
        let fullStarRating = Int(floor(rating))
        
        
        //give the decimal value a half star if greater than halfStarThreshold
        // eg: for 4.4,   4.4 - 4 = 0.4
        var isNextStarHalf = false
        if ((rating - floor(rating)) >= AppConstants.HALF_STAR_THRESHOLD) {
            isNextStarHalf = true
        }
        
        
        //fill all stars till full stars 
        //and then fill the half, 
        //then fill with empty stars
        for i in 1...AppConstants.MAXSTAR_RATING {
            let view = UIImageView()
            view.contentMode = .ScaleAspectFit
            if(i <= fullStarRating) {
                view.image = UIImage.fontAwesomeIconWithName(.Star, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
            } else {
                if(isNextStarHalf) {
                    view.image = UIImage.fontAwesomeIconWithName(.StarHalfFull, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
                    isNextStarHalf = false
                } else {
                    view.image = UIImage.fontAwesomeIconWithName(.StarO, textColor: UIColor.blackColor(), size: CGSizeMake(30, 30))
                }

            }
            self.addArrangedSubview(view)
        }
    }

    
    
    
    /*
     // Only override drawRect: if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func drawRect(rect: CGRect) {
     // Drawing code
     }
     */
    
}
