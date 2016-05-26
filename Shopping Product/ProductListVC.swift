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

    @IBOutlet weak var ProductCV: UICollectionView!
    private let spacing:CGFloat = 3.0
    private let numberOfItemsPerRow:CGFloat = 2.0
    private let cellHeight:CGFloat = 200
    
    
    
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
        ProductListStore.ProductListUpdated.listen(self, callback: { productList in
            
            self.ProductCV.reloadData()
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
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
        
        
        let activity = ProductListStore.getProductList()[row]
//        self.performSegueWithIdentifier("segueDetails", sender: activity)
    }
    
    //whole section edge space
    func collectionView(collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        //no section inset since there is only one section
        let sectionInsets = UIEdgeInsets(top: -40, left: spacing, bottom: spacing, right: spacing)
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return spacing
    }
}
extension ProductListVC: UICollectionViewDelegate {
    //All about collection view
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print(ProductListStore.getProductList().count)
        return ProductListStore.getProductList().count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> ProductCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("ProductCell", forIndexPath: indexPath) as! ProductCell
        cell.product = ProductListStore.getProductList()[indexPath.row]
        //cell.delegate = self
        return cell
    }
    
}

