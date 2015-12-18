/*
  Baus_CookingTest.swift
  Baus CookingTest
  Description: This file tests the log in functionality of the app. If the input username exist in the database,
               then the system will check the password that the user entered. If they match, then the user is able to log in.
               This file only test the valid input part, which means the input username and the password exist in the database.
  Created by Group7 on 12/2/15.

  Scenario:
  GIVEN at the log in page and type in the correct username and password

  WHEN I type in the user name at the "User" textField
  THEN the Text Field will actually present the username that the user just typed in
  
  WHEN I type in the password at the "Password" textField
  THEN the textField will present the securitied password that the user just typed in.

  WHEN I click the log in button
  THEN the app will navigate to the main page and I will be able to click the log out button to go back to the log in page
*/

import XCTest

class Baus_CookingTest2: XCTestCase {
        
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
      
      //Scenario2: Log In and Out with existing account
      
      
      //Given at the log in page and type in the correct username and password
      let app = XCUIApplication()
      let logInButton = app.buttons["Log In"]
      logInButton.tap()
      app.alerts["Incorrect Username or Password"].collectionViews.buttons["Ok"].tap()
      
      //When I type in the user name at the "User" textField
      let userTextField = app.textFields["User"]
      userTextField.tap()
      //Then the Text Field will actually present the username that the user just typed in
      userTextField.typeText("Runping")
      
      // When I type in the password at the "Password" textField
      let passwordSecureTextField = app.secureTextFields["Password"]
      passwordSecureTextField.tap()
      // Then the textField will present the securitied password that the user just typed in.
      passwordSecureTextField.typeText("wying123")
      
      //When I click the log in button
      logInButton.tap()
      
      //Then the app will navigate to the main page and user will be able to click the log out button to go back to the log in page
      app.navigationBars["Baus"].buttons["Log Out"].tap()
      
    }
    
}
