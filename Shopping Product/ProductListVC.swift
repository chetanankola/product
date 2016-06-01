//
//  ProductListVC.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/25/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit
import Signals

class ProductListVC: UIViewController, UIViewControllerPreviewingDelegate {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ProductCV: UICollectionView!
    private let spacing:CGFloat = 5.0
    private var numberOfItemsPerRow:CGFloat = 2.0
    private let cellHeight:CGFloat = 250
    
    
    var debounceTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductListStore.initStore()
        initListeners()
        initView()
        if( traitCollection.forceTouchCapability == .Available){
            registerForPreviewingWithDelegate(self, sourceView: ProductCV)
        }
    }
    
    func updateItemsPerRow(width:CGFloat) {
        if (width > AppConstants.IPHONE_6_WIDTH) {
            numberOfItemsPerRow = 3
        } else {
            numberOfItemsPerRow = 2
        }

    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        print(size)
        
        
        updateItemsPerRow(size.width)
        
        ProductCV.collectionViewLayout.invalidateLayout()
        
    }
    
    
    
    func previewingContext(previewingContext: UIViewControllerPreviewing, commitViewController viewControllerToCommit: UIViewController) {
        showViewController(viewControllerToCommit, sender: self)
    }
    func previewingContext(previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
        
        print("PEEK POP:\(location)")
        let indexPath = ProductCV?.indexPathForItemAtPoint(location)// else { return nil }
        let cell = ProductCV?.cellForItemAtIndexPath(indexPath!)// else { return nil }
    
        
        
        let storyboard = UIStoryboard(name: "ProductDetail", bundle: nil)
        let productDetailVC = storyboard.instantiateInitialViewController() as! ProductDetailVC
        
        
        productDetailVC.product = ProductListStore.getProductList()[indexPath!.row]
        
        
        let frameSpace = CGRectGetWidth(ProductCV.frame)
        let height = CGRectGetHeight(ProductCV.frame)
        productDetailVC.preferredContentSize = CGSize(width: frameSpace, height: height)
        previewingContext.sourceRect = cell!.frame
        
        return productDetailVC

    }
    
    func initView() {
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let width = screenSize.width
        updateItemsPerRow(width)
        ProductCV.registerNib(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    func initListeners() {
        ProductListStore.ProductListUpdated.listen(self, callback: { (productList, newProducts) in
            self.loadingIndicator.stopAnimating()
            self.ProductCV.performBatchUpdates({
                var offset = productList.count - newProducts.count
                for _ in newProducts {
                    let indexPath = NSIndexPath(forItem: offset, inSection: 0)
                    self.ProductCV.insertItemsAtIndexPaths([indexPath])
                    offset = offset + 1
                }
            }, completion: nil)
        })
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if (segue.identifier == "ProductDetailSegue") {
            let svc = segue.destinationViewController as! ProductDetailVC
            svc.product = sender as? Product
        }
    }
}




extension ProductListVC : UICollectionViewDelegateFlowLayout {
    
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let removePaddedSpace = spacing * (numberOfItemsPerRow + 1)
        let frameSpace = CGRectGetWidth(ProductCV!.frame)
        let width = (frameSpace - removePaddedSpace)/numberOfItemsPerRow
        return CGSizeMake(width, cellHeight)
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let row = indexPath.row
        let product = ProductListStore.getProductList()[row]
        self.performSegueWithIdentifier("ProductDetailSegue", sender: product)
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


extension ProductListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let frameHeight  = scrollView.frame.size.height
        let yOffset = scrollView.contentOffset.y

        //frameheight + YOffset = scrollerheight
        let contentHeight = scrollView.contentSize.height
        let earlyOffset = frameHeight//allows early request before the we reach end of page..
        let theYoffset = yOffset + earlyOffset
        let availScrollableHeight = max(contentHeight,frameHeight) - frameHeight

        if (theYoffset > availScrollableHeight) {
            ProductListStore.getNextPage()
            self.loadingIndicator.startAnimating()
        }
    }
    
}
extension ProductListVC: UICollectionViewDelegate {
    //All about collection view
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //print(ProductListStore.getProductList().count)
        return ProductListStore.getProductList().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ProductCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        cell.product = ProductListStore.getProductList()[indexPath.row]
        return cell
    }
    
}

