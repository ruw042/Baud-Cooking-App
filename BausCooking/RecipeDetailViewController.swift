/*
RecipeDetailViewController.swift
Baus Cooking
Description: This file will load the JSON code from the yummly.com. Type in the account name and the password that we get from
the yummly.com, we will get a bunch of code which represents all the information of the picture and the details of a recipe.
From the fucntion provided in this file, we can access the database of the yummly.com and get all the information of the recipe for
further use. This will be the window that we get the "encrypt code" from the yummly and then decrypt it in another file and display
the pictures and details in the end.
Created by Group7 on 11/16/15.
*/

import Foundation
import SwiftyJSON
import Alamofire
import AlamofireImage

class RecipeDetailViewController: UIViewController, UIScrollViewDelegate, UIPopoverPresentationControllerDelegate, UIActionSheetDelegate {

  var recipeID: String="" // Is set by the collection view while performing a segue to this controller.
  
  
  @IBOutlet weak var scrollView: UIScrollView!
  
  let spinner = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
  var recipeInfo: RecipeInfo?
  
  @IBOutlet weak var imageView: UIImageView!

  @IBOutlet weak var textView: UITextView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationController?.setNavigationBarHidden(false, animated: true)
    
    setupView()
    
    loadPhoto()
  }

  
  func setupView() {
    // Visual feedback to the user, so they know we're busy loading an image
    spinner.center = CGPoint(x: view.center.x, y: view.center.y - view.bounds.origin.y / 2.0)
    spinner.hidesWhenStopped = true
    spinner.startAnimating()
    view.addSubview(spinner)
    
    // A scroll view is used to allow zooming
//    scrollView.frame = view.bounds
    scrollView.delegate = self
    scrollView.minimumZoomScale = 1.0
    scrollView.maximumZoomScale = 3.0
    scrollView.zoomScale = 1.0
    view.addSubview(scrollView)
    
    imageView.contentMode = .ScaleAspectFit
    scrollView.addSubview(imageView)
    
    
    let doubleTapRecognizer = UITapGestureRecognizer(target: self, action: "handleDoubleTap:")
    doubleTapRecognizer.numberOfTapsRequired = 2
    doubleTapRecognizer.numberOfTouchesRequired = 1
    scrollView.addGestureRecognizer(doubleTapRecognizer)
  }
  
  func handleDoubleTap(recognizer: UITapGestureRecognizer!) {
    let pointInView = recognizer.locationInView(self.imageView)
    self.zoomInZoomOut(pointInView)
  }
  
  
  func loadPhoto() {
    
    Alamofire.request(Recipe.Router.RecipeDetail(self.recipeID)).validate().responseObject(){
      (response: Response<RecipeInfo, NSError>) in
    
      if let recipeInfo = response.result.value{
    
            self.recipeInfo = recipeInfo
    
              dispatch_async(dispatch_get_main_queue()) {
              self.addButtomBar()
              self.title = self.recipeInfo!.name
            }
    
            Alamofire.request(.GET, self.recipeInfo!.url).responseImage() {
              [weak self] response in
              guard response.result.error == nil else{
    
                // got an error in getting the data, need to handle it
                print("error calling GET on /posts/1")
                print(response.result.error!)
                return
    
              }
    
              if let img = response.result.value{
                self!.imageView.image = img
                self!.imageView.frame = self!.centerFrameFromImage(img)
    
                self!.spinner.stopAnimating()
    
                self!.centerScrollViewContents()
                self?.addTextField()
                
              }
            }
            
    
            
          }
          
        }
  }

  override func viewWillAppear(animated: Bool) {
    super.viewWillAppear(animated)
    
    // If the network is fast, the photo may be loaded before the view appears, but we still want an animation
    if recipeInfo != nil {
      navigationController?.setToolbarHidden(false, animated: true)
    }
  }
  
  override func viewWillDisappear(animated: Bool) {
    super.viewWillDisappear(animated)
    navigationController?.setToolbarHidden(true, animated: true)
  }
  
  func addTextField() {
    
    var makeText = ""
    for string in (recipeInfo?.ingredients)!{
      
      makeText += string + "\r\n"
      
    }
    textView.text  = makeText
    
  }
  
  // MARK: Bottom Bar
  
  func addButtomBar() {
    
    
    var items = [UIBarButtonItem]()
    
//    let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .FlexibleSpace, target: nil, action: nil)
    
    items.append(barButtonItemWithImageNamed("hamburger", title: nil, action: "showDetails"))
//    
//    items.append(flexibleSpace)
    
    let rating = recipeInfo!.rating! as Float
    items.append(barButtonItemWithImageNamed("like", title: String(rating)))
    
    
    self.setToolbarItems(items, animated: true)
    navigationController?.setToolbarHidden(false, animated: true)
  }
  
  func barButtonItemWithImageNamed(imageName: String?, title: String?, action: Selector? = nil) -> UIBarButtonItem {
    
    let button = UIButton(type: UIButtonType.Custom)
    
    if imageName != nil {
      button.setImage(UIImage(named: imageName!)!.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
    }
    
    if title != nil {
      button.setTitle(title, forState: .Normal)
      button.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 10.0, bottom: 0.0, right: 0.0)
      
      let font = UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote)
      button.titleLabel?.font = font
    }
    
    let size = button.sizeThatFits(CGSize(width: 90.0, height: 30.0))
    button.frame.size = CGSize(width: min(size.width + 10.0, 60), height: size.height)
    
    if action != nil {
      button.addTarget(self, action: action!, forControlEvents: .TouchUpInside)
    }
    
    let barButton = UIBarButtonItem(customView: button)
    
    return barButton
  }
  
  
  // MARK: ScrollView
  
  func centerFrameFromImage(image: UIImage?) -> CGRect {
    if image == nil {
      return CGRectZero
    }
    
    let scaleFactor = scrollView.frame.size.width / image!.size.width
    let newHeight = image!.size.height * scaleFactor
    
    var newImageSize = CGSize(width: scrollView.frame.size.width, height: newHeight)
    
    newImageSize.height = min(scrollView.frame.size.height, newImageSize.height)
    
    let centerFrame = CGRect(x: 0.0, y: scrollView.frame.size.height/2 - newImageSize.height/2, width: newImageSize.width, height: newImageSize.height)
    
    return centerFrame
  }
  
  func scrollViewDidZoom(scrollView: UIScrollView) {
    self.centerScrollViewContents()
  }
  
  func centerScrollViewContents() {
    let boundsSize = scrollView.frame
    var contentsFrame = self.imageView.frame
    
    if contentsFrame.size.width < boundsSize.width {
      contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
    } else {
      contentsFrame.origin.x = 0.0
    }
    
    if contentsFrame.size.height < boundsSize.height {
      contentsFrame.origin.y = (boundsSize.height - scrollView.scrollIndicatorInsets.top - scrollView.scrollIndicatorInsets.bottom - contentsFrame.size.height) / 2.0
    } else {
      contentsFrame.origin.y = 0.0
    }
    
    self.imageView.frame = contentsFrame
  }
  
  func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
    return self.imageView
  }
  
  func zoomInZoomOut(point: CGPoint!) {
    let newZoomScale = self.scrollView.zoomScale > (self.scrollView.maximumZoomScale/2) ? self.scrollView.minimumZoomScale : self.scrollView.maximumZoomScale
    
    let scrollViewSize = self.scrollView.bounds.size
    
    let width = scrollViewSize.width / newZoomScale
    let height = scrollViewSize.height / newZoomScale
    let x = point.x - (width / 2.0)
    let y = point.y - (height / 2.0)
    
    let rectToZoom = CGRect(x: x, y: y, width: width, height: height)
    
    self.scrollView.zoomToRect(rectToZoom, animated: true)
  }
  
  
}
