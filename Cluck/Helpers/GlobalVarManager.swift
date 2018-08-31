//
//  GlobalVarManager.swift
//  Cluck
//
//  Created by Вячеслав Рожнов on 31.08.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import Foundation

class QuestionsManager {
  
  var user: User = User()
  
  static let sharedInstance = QuestionsManager()
  
  private init() {
    
  }
  
  func reset() {
    user = User()
  }
}
