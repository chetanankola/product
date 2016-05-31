//
//  ProductDetailVC.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/27/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    
    private let spacing:CGFloat = 0.0
    @IBOutlet weak var ProductDetailCV: UICollectionView!
    var product: Product? {
        didSet {
            
        }
    }
    
    
    func scrollToIndex(product:Product) {
        if let index = ProductListStore.findProduct(product) {
            print("Scrolling to the product at index: \(index)")
            
            let indexPath = NSIndexPath(forItem: index, inSection: 0)
            
            ProductDetailCV.scrollToItemAtIndexPath(indexPath, atScrollPosition: .CenteredHorizontally, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initView()
        ProductDetailCV.reloadData()

    }
    
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollToIndex(self.product!)
        }
    }
//    override func viewDidAppear(animated: Bool) {
//        dispatch_async(dispatch_get_main_queue()) {
//            self.scrollToIndex(self.product!)
//        }
//    }

    
    func initView() {
        ProductDetailCV.registerNib(UINib(nibName: "ProductDetailCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}





extension ProductDetailVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let frameSpace = CGRectGetWidth(ProductDetailCV!.frame)
        let height = CGRectGetHeight(ProductDetailCV!.frame)
        return CGSizeMake(frameSpace, height)
    }
    

    
    //whole section edge space
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //no section inset since there is only one section
        let sectionInsets = UIEdgeInsets(top: 65+spacing, left: spacing, bottom: spacing+50, right: spacing)
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
}


extension ProductDetailVC: UICollectionViewDelegate {
    //All about collection view
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ProductListStore.getProductList().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ProductDetailCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductDetailCell", forIndexPath: indexPath) as! ProductDetailCell
        cell.product = ProductListStore.getProductList()[indexPath.row]
        return cell
    }
    
}
