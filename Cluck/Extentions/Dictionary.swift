
//  Created by Вячеслав Рожнов on 31.07.2018.

//

import Foundation

extension Dictionary {
  func jsonString() -> NSString? {
    let jsonData = try? JSONSerialization.data(withJSONObject: self, options: [])
    guard jsonData != nil else {return nil}
    let jsonString = String(data: jsonData!, encoding: .utf8)
    guard jsonString != nil else {return nil}
    return jsonString! as NSString
  }
  
}
