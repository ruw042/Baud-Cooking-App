/*
  Baus_CookingTest.swift
  Baus CookingTest
  Description: This file is going to test the functionality of searching for ingredients. Basically after the user logged in
               with the right account name and account password, the user will be able to do searching in main page. The user
               can type in the ingredients that he or she is looking for and click the submit button, and then the search
               result will pop up. The user can then click on any search result in this page to see the details.
  Created by Group7 on 12/2/15.

  Scenario:
  GIVEN the user log in into the app and be at the main page

  WHEN the user input some ingredient in the TextField
  THEN the textField will present the ingredents that the user just typed

  WHEN user click on Submit botton
  THEN the app will navigate to the page with detailed recipe list and the I will be able to scroll down to view more receipes
*/

import XCTest

class Baus_CookingTest3: XCTestCase {
        
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
      
      
      
      //Scenario3: Successfully searching. Input: legal input. expected Output: details of the recipe.
      
      //Given the user log in into the app and be at the main page
      let app = XCUIApplication()
      let userTextField = app.textFields["User"]
      userTextField.tap()
      userTextField.typeText("Runping")
      
      let passwordSecureTextField = app.secureTextFields["Password"]
      passwordSecureTextField.tap()
      passwordSecureTextField.typeText("wying123")
      app.buttons["Log In"].tap()
      
      //When the user input some ingredient in the TextField
      let typeInAnIngredientTextField = app.textFields["Type in an ingredient"]
      typeInAnIngredientTextField.tap()
      //Then the textField will present the ingredents that the user just typed
      typeInAnIngredientTextField.typeText("soup")
      //When user click on Submit botton
      app.buttons["Submit"].tap()
      
      //Then the app will navigate to the page with detailed recipe list and the user will be able to scroll down to view more receipes
      app.otherElements.containingType(.NavigationBar, identifier:"Recipes").childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.Other).element.childrenMatchingType(.CollectionView).element.tap()
      
      
      
    }
    
}
