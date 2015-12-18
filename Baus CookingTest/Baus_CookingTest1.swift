/*
  Baus_CookingTest.swift
  Baus CookingTest
  Description: This file will test the sign up functionality. Normally when the user click on the sign up button at the homepage, the user will goes to the sign up page, where the user can input any account name that is not exsit in the database. And then the user can input the new password of his account. And after the user click the button login on this page, the user should be able to view the main page of this app. But if the user leave the username and the password blank at the sign up page and then click on the sign up button, there will be a alert.
  Created by Group7 on 12/2/15.

  Scenario:
  GIVEN the signup page where the text fields (username, and password) are blank,
  WHEN I click the sign up button
  THEN the error alert will pop out and user can click the ok to dismiss the alert
*/

import XCTest

class Baus_CookingTest1: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
      
      //Scenario1: New user sing up
      
      // Given navigation to the sign up page and leaving the sign up text field blank
      let app = XCUIApplication()
      let signUpButton = app.buttons["Sign Up"]
      
      // When I click the sign up button
      signUpButton.tap()
      signUpButton.tap()
      
      // Then the error alert will pop out and the user can click the ok to dismiss the error alert
      app.alerts["Incorrect Username or Password"].collectionViews.buttons["Ok"].tap()
      app.navigationBars["Sign Up"].buttons["Log In"].tap()
      
      
    }
    
}
