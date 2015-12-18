//
/*  
  Baus_CookingTest4.swift
  Baus Cooking

  Description: This file shows what will happen typing in illegal input at the searching page. Which means when the input is blank, then there will be a alert poping up. 

  Created by Runping Wang on 12/4/15.
  Created by Group7 on 12/2/15.

  Scenario:
  GIVEN the user log in into the app and be at the main page

  WHEN the user leave the ingredient text field empty and click the submit button
  THEN the app will navigate to the page with detailed recipe list first and then go back to the main page automatically with the error alert poped out
*/

import XCTest

class Baus_CookingTest4: XCTestCase {
        
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
      
      //Scenario4: Illegal input: empty and click the submit. Expected output: alert
      
      //Given the user log in into the app and be at the main page
      let app = XCUIApplication()
      let userTextField = app.textFields["User"]
      userTextField.tap()
      userTextField.typeText("Runping")
      
      let passwordSecureTextField = app.secureTextFields["Password"]
      passwordSecureTextField.tap()
      passwordSecureTextField.typeText("wying123")
      app.buttons["Log In"].tap()
      
      //When the user leave the ingredient text field empty and click the submit button
      app.buttons["Submit"].tap()
      
      //Then the app will navigate to the page with detailed recipe list first and then go back to the main page automatically with the error alert poped out
      app.alerts["Recipe not Found"].collectionViews.buttons["Ok"].tap()
      
    }
    
}
