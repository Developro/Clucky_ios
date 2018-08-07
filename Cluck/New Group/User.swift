//
//  User.swift
//  Cluck
//
//  Created by Наталья Синицына on 16.06.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import Foundation
import SwiftyJSON
import GoogleSignIn

class User: NSObject {
  
  var name: String = ""
  var last: String = ""
  var emailAddress: String = ""
  var stars: Int = 0
  var id: Double = 0
  var login:String = ""
  var logo:String = ""
  var typeConnect :TypeConnect = .defaults
  
  enum TypeConnect {
    case vk, fb, gplus, defaults
  }
  
  convenience init(json: JSON) {
    self.init()
    self.typeConnect = .vk
    self.name = json["first_name"].stringValue
    self.last = json["last_name"].stringValue
    self.emailAddress = "@vk" //в контакте нет email
    self.stars = 0
    self.id   = json["id"].doubleValue
    self.login = json["first_name"].stringValue
    self.logo = json["photo_50"].stringValue
  }
  
  convenience init(gplusUser: GIDGoogleUser) {
    self.init()
    self.typeConnect = .gplus
    self.name = gplusUser.profile.givenName
    self.last = gplusUser.profile.familyName
    self.emailAddress = gplusUser.profile.email
    self.stars = 0
    self.id   = Double(gplusUser.userID)!
    self.login = gplusUser.profile.givenName
    self.logo = gplusUser.profile.imageURL(withDimension: 50).absoluteString
  }
  
  convenience init(dictForFB: [String: AnyObject]) {
    self.init()
    self.typeConnect = .fb
    self.stars = 0
    self.login = ""
    self.logo = ""
    if let first_name = dictForFB["first_name"]?.description {
      self.name = first_name
    }
    if let last_name = dictForFB["last_name"]?.description {
      self.last = last_name
    }
    if let email = dictForFB["email"]?.description {
      self.emailAddress = email
    }
    if let id = Double((dictForFB["id"]?.description)!) {
      self.id = id
    }
    if let picture = dictForFB["picture"], let data = picture["data"] {
      self.logo =  ((data as! [String: AnyObject])["url"]?.description)!
    }
    

  }
  
}
