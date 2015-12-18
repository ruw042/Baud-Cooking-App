//
//  UIViewControllerExtension.swift
//  ParseTutorial
//
//  Created by Runping Wang on 10/8/15.
//  Copyright (c) 2015 Runping Wang. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
  
  func showErrorView(error: NSError) {
    
      let alert = UIAlertController(title: "Incorrect Username or Password", message: "Please Input the Correct Username and Password or Sign up", preferredStyle: UIAlertControllerStyle.Alert)
      alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
      presentViewController(alert, animated: true, completion: nil)
    
  }
}