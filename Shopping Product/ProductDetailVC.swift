//
//  ProductDetailVC.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/27/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit

class ProductDetailVC: UIViewController {

    var popped:Bool = false
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
        initListeners()
        ProductDetailCV.reloadData()

    }
    
    
    func initListeners() {
        ProductListStore.ProductListUpdated.listen(self, callback: { (productList, newProducts) in
            self.ProductDetailCV.performBatchUpdates({
                var offset = productList.count - newProducts.count
                for _ in newProducts {
                    let indexPath = NSIndexPath(forItem: offset, inSection: 0)
                    self.ProductDetailCV.insertItemsAtIndexPaths([indexPath])
                    offset = offset + 1
                }
                }, completion: nil)
        })
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        ProductDetailCV.collectionViewLayout.invalidateLayout()
        
    }
    override func viewWillAppear(animated: Bool) {
        dispatch_async(dispatch_get_main_queue()) {
            self.scrollToIndex(self.product!)
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        if (popped) {
            ProductDetailCV.collectionViewLayout.invalidateLayout()
        }
    }
    
    func initView() {
        ProductDetailCV.registerNib(UINib(nibName: "ProductDetailCell", bundle: nil), forCellWithReuseIdentifier: "ProductDetailCell")
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}





extension ProductDetailVC : UICollectionViewDelegateFlowLayout {
    
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let pageWidth = ProductDetailCV.frame.size.width
        let currentPage = ProductDetailCV.contentOffset.x / pageWidth
        

        
        print(currentPage)
        
        if (Int(currentPage) == ProductListStore.getProductList().count - 1) {
            print("hit the end of page")
            ProductListStore.getNextPage()
        }
        
    }
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = CGRectGetWidth(ProductDetailCV!.frame)
        let height = CGRectGetHeight(ProductDetailCV!.frame)
        return CGSizeMake(width, height)
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
