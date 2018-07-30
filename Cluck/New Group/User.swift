//
//  User.swift
//  Cluck
//
//  Created by Наталья Синицына on 16.06.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject {
  
  var name: String = ""
  var last: String = ""
  var emailAddress: String = ""
  var stars: Int = 0
  var id: Int = 0
  var login:String = ""
  var logo:String = ""
  
  convenience init(json: JSON) {
    self.init()
    self.name = json["first_name"].stringValue
    self.last = json["last_name"].stringValue
    self.emailAddress = "@покаТак"
    self.stars = 0
    self.id   = json["id"].intValue
    self.login = json["first_name"].stringValue
    self.logo = json["photo_50"].stringValue
  }
}
