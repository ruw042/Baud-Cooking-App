/*
  MainPageViewController.swift
  Description: This file manage the searching page of this app. Where the customer types in the ingredients that he or she
  wants to search, and this file will pass in the string and run the search for the recipe by running the RecepeBrowserCollectionViewController file. This file contain the UI of the searching page and also some alerts(like recipe not found) and instructions(like please input the correct ingredients) that should be poped out when the input is illegal.
  Designed by: Group7
 */

import UIKit
import Alamofire

class MainPageViewController: UIViewController {

    @IBOutlet weak var ingredient: UITextField!
    @IBOutlet weak var submit: UIButton!
  
    var alert = false
  
//  var recipeInfo: RecipeInfo?
    var recipeName:String? {
      return ingredient.text
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()// Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  override func viewDidAppear(animated: Bool) {
    if(alert == true){
      let alert = UIAlertController(title: "Recipe not Found", message: "Please Input the Correct Ingredients", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      
      self.presentViewController(alert, animated: true, completion: nil)
      self.alert = false
    }
  }
  
  
    
  
  @IBAction func pressed(sender: UIButton) {
      
       
    }



  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
    if segue.identifier == "ShowRecipe" {
      (segue.destinationViewController as! RecipeBrowserCollectionViewController).ingredient = ingredient.text!
    }
  }

      //      // 3
//      query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in
//        if (error != nil) {
//          /*//print("Successfully retrieved: \(objects)")
//          let alertController = UIAlertController(title: "Search Ingredient", message:
//            "item found", preferredStyle: UIAlertControllerStyle.Alert)
//          alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.Default,handler: nil))
//          
//          self.presentViewController(alertController, animated: true, completion: nil)*/
//          
//        } else {
//          print("Error: \(error) \(error!.userInfo)")
//        }
//      }
  
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
