//
//  LoginViewController.swift
//  ParseTutorial
//
//  Created by Runping Wang on 10/6/15.
//  Copyright (c) 2015 Runping Wang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
  
  @IBOutlet weak var userTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  
  
  let mainPageSegue = "mainPage"
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    /*
    if let user = PFUser.currentUser() {
      if user.isAuthenticated() {
        self.performSegueWithIdentifier(mainPageSegue, sender: nil)
      }
    }*/
  }
  
  // MARK: - Actions
  @IBAction func logInPressed(sender: AnyObject) {
    PFUser.logInWithUsernameInBackground(userTextField.text!, password: passwordTextField.text!) { user, error in
      if user != nil {
        self.performSegueWithIdentifier(self.mainPageSegue, sender: nil)
      } else if let error = error {
        self.showErrorView(error)
      }
    }
  }
}
