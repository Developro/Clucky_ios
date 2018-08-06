
//  Created by Вячеслав Рожнов

import Foundation
import SwiftyJSON

//typealias dataCompletion = ([Users]?, Error?) -> Void

class VKService {
  
  let apiKey:String = "19d857f619d857f619d857f6c019bd36b6119d819d857f64281a332b84350b6783f427c"
  
  var token: String {
    get {
      if let t = app.userDefaults.object(forKey: "tokenVK") as? String {
        return t
      } else {
        return ""
      }
    }
    
    set {
      app.userDefaults.set(newValue, forKey: "tokenVK")
    }
  }
  
  enum authorizationError: Error {
    case accessTokenHasExpired
  }
  
  func getUsers(token: String, completion: (([User]?, Error?) -> Void)? = nil) {
    guard let url = URL(string:"https://api.vk.com/method/users.get?fields=sex,has_photo,photo_50,city,verified&access_token=\(token)&v=5.80") else {return}
    let session = URLSession.shared
    let task = session.dataTask(with: url) { (data, response, error) in
      
      if let error = error {
        completion?(nil, error)
        return
      }
      
      
      
      if let data = data, let json = try? JSON(data: data) {
        let error = json["error"]["error_msg"].stringValue
        
        if error == "User authorization failed: access_token has expired." {
          completion?(nil, authorizationError.accessTokenHasExpired)
          return
          //переполучить токен
        }
        
        let users = json["response"].arrayValue.map { User(json: $0) }
        completion?(users, nil)
      }
      
      return
      
    }
    task.resume()
  }
  
  func vkAuthRequest() -> URLRequest? {
    var urlComponents = URLComponents()
    urlComponents.scheme = "https"
    urlComponents.host = "oauth.vk.com"
    urlComponents.path = "/authorize"
    urlComponents.queryItems = [
      URLQueryItem(name: "client_id", value: "6644032"),
      URLQueryItem(name: "display", value: "mobile"),
      URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
      URLQueryItem(name: "scope", value: "wall,friends,groups"),
      URLQueryItem(name: "response_type", value: "token"),
      URLQueryItem(name: "v", value: "5.80")
    ]
    guard let url = urlComponents.url else {return nil}
    
    return URLRequest(url: url)
  }
  
}


