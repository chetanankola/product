//
//  ProductListVC.swift
//  Shopping Product
//
//  Created by Chetan Ankola on 5/25/16.
//  Copyright © 2016 Chetan Ankola. All rights reserved.
//

import UIKit
import Signals

class ProductListVC: UIViewController {

    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ProductCV: UICollectionView!
    private let spacing:CGFloat = 5.0
    private let numberOfItemsPerRow:CGFloat = 2.0
    private let cellHeight:CGFloat = 200
    
    
    var debounceTimer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ProductListStore.initStore()
        initListeners()
        initView()
        
    }
    
    func initView() {
        ProductCV.registerNib(UINib(nibName: "ProductCell", bundle: nil), forCellWithReuseIdentifier: "ProductCell")
    }
    func initListeners() {
        ProductListStore.ProductListUpdated.listen(self, callback: { (productList, newProducts) in
            
//            dispatch_async(dispatch_get_main_queue()) {
//                self.ProductCV.reloadData()
//            }
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
            svc.product = sender as! Product
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
            
            
//            if debounceTimer != nil {
//                debounceTimer?.invalidate()
//            }
//            debounceTimer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(ProductListVC.debounceGetNextPage(_:)), userInfo: nil, repeats: false)
//            print("trying to fetch next page")
            
            ProductListStore.getNextPage()
            self.loadingIndicator.startAnimating()
        }

        
//        print("yoffset \(theYoffset) availHeight \(availScrollableHeight)")

    }
//    func debounceGetNextPage(timer: NSTimer) {
//        print("trying to fetch next page")
//        ProductListStore.getNextPage()
//    }
    
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

