//
//  RecipeBrowserCollectionViewController.swift
//  Baus Cooking
//
//  Created by chengyancy on 11/14/15.
//  Copyright © 2015 Ron Kliffer. All rights reserved.
//

import Foundation
import UIKit
import AlamofireImage
import Alamofire
import SwiftyJSON

class RecipeBrowserCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
  
  var recipes = NSMutableOrderedSet()
      let imageCache = NSCache()
  let refreshControl = UIRefreshControl()
  
  var populatingPhotos = false
  var start = 0
  var ingredient = ""
  var maxCount = 0
  
  let PhotoBrowserCellIdentifier = "PhotoBrowserCell"
  let PhotoBrowserFooterViewIdentifier = "PhotoBrowserFooterView"
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupView()
    
    populatePhotos()
  }

  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    self.imageCache.removeAllObjects()
  }

  
  override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int{
    return recipes.count
  }
  
  
  override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
    
    let cell = collectionView.dequeueReusableCellWithReuseIdentifier(PhotoBrowserCellIdentifier, forIndexPath: indexPath) as! PhotoBrowserCollectionViewCell
    
    let imageURL = (recipes.objectAtIndex(indexPath.row) as! RecipeInfo).url
    cell.imageView.image = nil
    cell.request?.cancel()
    
    
    if let image = self.imageCache.objectForKey(imageURL) as? UIImage { // Use the local cache if possible
      cell.imageView.image = image
    } else { // Download from the internet
      cell.imageView.image = nil
    
      cell.request = Alamofire.request(.GET, imageURL).validate().responseImage() {
        [weak self] response in
        guard response.result.error == nil else{
          // got an error in getting the data, need to handle it
          print("error calling GET on /posts/1")
          print(response.result.error!)
          return

        }
          
//        else {
//          
          if let img = response.result.value {
            self!.imageCache.setObject(img, forKey: (response.request?.URLString)!)
            cell.imageView.image = img
          }
//        }
        
      }
    }
    return cell
  }
  
  override func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
    return collectionView.dequeueReusableSupplementaryViewOfKind(kind, withReuseIdentifier: PhotoBrowserFooterViewIdentifier, forIndexPath: indexPath)
  }
  
  override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
    performSegueWithIdentifier("ShowRecipe", sender: (self.recipes.objectAtIndex(indexPath.item) as! RecipeInfo))
  }

  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "ShowRecipe" {
      (segue.destinationViewController as! RecipeDetailViewController).recipeID = (sender as! RecipeInfo).id
      (segue.destinationViewController as! RecipeDetailViewController).hidesBottomBarWhenPushed = true
    }
  }
  
  
  func setupView() {
    navigationController?.setNavigationBarHidden(false, animated: true)
    
    let layout = UICollectionViewFlowLayout()
    let itemWidth = (view.bounds.size.width - 2) / 3
    layout.itemSize = CGSize(width: itemWidth, height: itemWidth)
    layout.minimumInteritemSpacing = 1.0
    layout.minimumLineSpacing = 1.0
    layout.footerReferenceSize = CGSize(width: collectionView!.bounds.size.width, height: 100.0)
    
    collectionView!.collectionViewLayout = layout
    
    navigationItem.title = "Recipes"
    
    collectionView!.registerClass(PhotoBrowserCollectionViewCell.classForCoder(), forCellWithReuseIdentifier: PhotoBrowserCellIdentifier)
    collectionView!.registerClass(PhotoBrowserCollectionViewLoadingCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: PhotoBrowserFooterViewIdentifier)
    
    refreshControl.tintColor = UIColor.whiteColor()
    refreshControl.addTarget(self, action: "handleRefresh", forControlEvents: .ValueChanged)
    collectionView!.addSubview(refreshControl)

    
  }
  
  func populatePhotos() {
    if populatingPhotos {
      return
    }
    
    if self.start != 0 && self.start + 10 >= self.maxCount{
      return
    }
    
    self.populatingPhotos = true
    
    
    Alamofire.request(Recipe.Router.RecipeInfo(self.ingredient,self.start)).validate().responseJSON(){
      response in
        if let value = response.result.value {
          let post = JSON(value)
          
          self.maxCount = post["totalMatchCount"].int!
          
          dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0)) {
            
            let recipeInfo = ((value as! NSDictionary).valueForKey("matches") as! [NSDictionary]).map{
              RecipeInfo(id: $0["id"] as! String, url: $0["imageUrlsBySize"]!["90"] as! String)
            }
            self.recipes.addObjectsFromArray(recipeInfo)
            
            
            self.collectionView!.reloadData()
            
            self.start += 10
            
          }
      }
        else{
          print(response.result.error!)
        }
      
      self.populatingPhotos = false
    }
  
  }

  
  override func scrollViewDidScroll(scrollView: UIScrollView) {

    if scrollView.contentOffset.y + view.frame.size.height > scrollView.contentSize.height * 0.8 {
      
        populatePhotos()
    }
  }
  
  
  func handleRefresh() {
    refreshControl.beginRefreshing()
    
    // Reset the model
    self.recipes.removeAllObjects()
    self.start = 0
    
    // Refresh the UI
    self.collectionView!.reloadData()
    
    // We have our own spinner
    refreshControl.endRefreshing()
    
    populatePhotos()
  }
  
}



class PhotoBrowserCollectionViewCell: UICollectionViewCell {
  let imageView = UIImageView()
  var request: Alamofire.Request?
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    backgroundColor = UIColor(white: 0.1, alpha: 1.0)
    
    imageView.frame = bounds
    addSubview(imageView)
  }
}

class PhotoBrowserCollectionViewLoadingCell: UICollectionReusableView {
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.WhiteLarge)
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
  }
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    spinner.startAnimating()
    spinner.center = self.center
    addSubview(spinner)
  }

}
