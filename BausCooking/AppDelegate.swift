/*
  AppDelegate.swift
  Description: this file contain the basic information of the UI. For instance, the barstyle and the color. Most of it is about the
  appearance of this app. Since Xcode is really power in UI designing, most of it can be accomplished by dragging and clicking on the
  main.storyboard.
  Designed by: Group 7
 */

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  
  func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
    Parse.setApplicationId("W6c5xma0qKD4LaUs6NOZF0tXaCFLP7xO7TEK04bp", clientKey: "zZ7Qu2C7GOTIXukctRS0kFkLcfNlCieIg2GhKWri")
    
    UINavigationBar.appearance().barStyle = .BlackTranslucent
    UINavigationBar.appearance().tintColor = UIColor.whiteColor()
    
    UIToolbar.appearance().barStyle = .BlackTranslucent
    UITabBar.appearance().barStyle = .Black
    UITabBar.appearance().translucent = true
    UITabBar.appearance().tintColor = UIColor.whiteColor()
    
    UIBarButtonItem.appearance().tintColor = UIColor.whiteColor()
    
    UIButton.appearance().tintColor = UIColor.whiteColor()
    
    /*
        let player = PFObject(className: "Ingredient")
        player.setObject("Butter", forKey: "Name")
    
        player.saveInBackgroundWithBlock { (succeeded, error) -> Void in
        if succeeded {
        print("Object Uploaded")
      } else {
        print("Error: \(error) \(error!.userInfo)")
      }
    }//2
//    player.save()//3
    
//    let player = PFObject(className: "Player")
//    player.setObject("Jack", forKey: "Name")
//    player.setObject(840, forKey: "Score")
//    player.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//      if succeeded {
//        println("Object Uploaded")
//      } else {
//        println("Error: \(error) \(error.userInfo!)")
//      }
//    }
    
//    let query = PFQuery(className: "Player") //1
//    query.whereKey("Name", equalTo: "John") //2
//    query.whereKey("Score", greaterThan: 1000) //3
//    query.findObjectsInBackgroundWithBlock { (objects, error) -> Void in //4
//      if error == nil {
//        println("Successfully retrieved: \(objects)")
//      } else {
//        println("Error: \(error) \(error.userInfo!)")
//      }
//    }
    */
    
    return true
  }
  
  func applicationWillResignActive(application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
  }
  
  func applicationDidEnterBackground(application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }
  
  func applicationWillEnterForeground(application: UIApplication) {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
  }
  
  func applicationDidBecomeActive(application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }
  
  func applicationWillTerminate(application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }
  
  
}

