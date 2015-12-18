//
//  Recipe.swift
//  Baus Cooking
//
//  Created by chengyancy on 11/9/15.
//  Copyright © 2015 Ron Kliffer. All rights reserved.
//

import Foundation

import UIKit
import SwiftyJSON
import Alamofire


public protocol ResponseObjectSerializable {
  init?(response: NSHTTPURLResponse, representation: AnyObject)
}

extension Request {
  public func responseObject<T: ResponseObjectSerializable>(completionHandler: Response<T, NSError> -> Void) -> Self {
    let responseSerializer = ResponseSerializer<T, NSError> { request, response, data, error in
      guard error == nil else { return .Failure(error!) }
      
      let JSONResponseSerializer = Request.JSONResponseSerializer(options: .AllowFragments)
      let result = JSONResponseSerializer.serializeResponse(request, response, data, error)
      
      switch result {
      case .Success(let value):
        if let
          response = response,
          responseObject = T(response: response, representation: value)
        {
          return .Success(responseObject)
        } else {
          let failureReason = "JSON could not be serialized into response object: \(value)"
          let error = Error.errorWithCode(.JSONSerializationFailed, failureReason: failureReason)
          return .Failure(error)
        }
      case .Failure(let error):
        return .Failure(error)
      }
    }
    
    return response(responseSerializer: responseSerializer, completionHandler: completionHandler)
  }
}


//class Comment {
//  let userFullname: String
//  let userPictureURL: String
//  let commentBody: String
//
//  init(JSON: AnyObject) {
//    userFullname = JSON.valueForKeyPath("user.fullname") as! String
//    userPictureURL = JSON.valueForKeyPath("user.userpic_url") as! String
//    commentBody = JSON.valueForKeyPath("body") as! String
//  }
//}

//TODO
struct Recipe {
  
  enum Router: URLRequestConvertible {
    static let baseURLString = "http://api.yummly.com/v1/"
    
    static let appID = "e336dc41"
    static let appKey = "cd3d69b466e086495a044f56b1aa0909"
    
    case RecipeInfo(String,Int)
    case RecipeDetail(String)

    var URLRequest: NSMutableURLRequest {
      let result: (path: String, parameters:[String: AnyObject]) = {
        
        switch self {
        case .RecipeInfo( let name,let page):
          
          let nameArr = name.componentsSeparatedByString(" ")
          var buildString = ""
          for name in nameArr{
            buildString += name + "+"
          }
          let params = ["_app_id": Router.appID, "_app_key": Router.appKey, "q": buildString, "maxResult": "15" , "start":"\(page)"]
          return ("api/recipes",params)
          
        case .RecipeDetail(let id):
          
          let params = ["_app_id": Router.appID, "_app_key": Router.appKey]
          return ("api/recipe/\(id)", params)
          
        }
        
      }()
    
      let URL = NSURL(string: Router.baseURLString)
      let URLRequest = NSURLRequest(URL: URL!.URLByAppendingPathComponent(result.path))
      let encoding = Alamofire.ParameterEncoding.URL
      
      return encoding.encode(URLRequest, parameters: result.parameters).0
    }
  }
  
}

class RecipeInfo: NSObject,ResponseObjectSerializable{
  
  let id: String
  let url: String
  var rating: Float?
  var name: String?
  var ingredients: [String]?
  
  
  
  init(id: String, url: String) {
        self.id = id
        self.url = url

  }
  
  required init?(response: NSHTTPURLResponse, representation: AnyObject) {
    self.id = representation.valueForKeyPath("id") as! String
    
    
    let array = representation.valueForKeyPath("images") as! NSArray
    self.url = JSON(array[0])["hostedLargeUrl"].string!
    
    self.rating = representation.valueForKeyPath("rating") as? Float
    self.name = representation.valueForKeyPath("name") as? String
    
    self.ingredients = representation.valueForKeyPath("ingredientLines") as? [String]
  }
  

  override func isEqual(object: AnyObject!) -> Bool {
    return (object as! RecipeInfo).id == self.id
  }

  override var hash: Int {
    
    let scanner = NSScanner(string: (self as RecipeInfo).id)
    
    scanner.charactersToBeSkipped = NSCharacterSet.decimalDigitCharacterSet().invertedSet
    
    var value: Int = 0
    if scanner.scanInteger(&value) {
      return value
    }
    else{
      return 0
    }
  }

  
}
