import UIKit
import Magic
import GoogleSignIn
import WebKit
import FBSDKLoginKit
import SwiftyJSON

class LoginViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate  {
  
  //Outlets
  @IBOutlet weak var loginRegistrationSegment: UISegmentedControl!
  @IBOutlet weak var emailTextField: UITextField!
  @IBOutlet weak var passwordTextField: UITextField!
  @IBOutlet weak var nameTextField: UITextField!
  @IBOutlet weak var loginButton: UIButton!
  @IBOutlet weak var loginGoogleButton: UIButton!
  @IBOutlet weak var loginVKButton: UIButton!
  
  
  
  let signIn = GIDSignIn.sharedInstance()
  var webView = WKWebView()
  let nc = NotificationCenter.default
  
  let queue: OperationQueue = {
    let queue = OperationQueue()
    queue.qualityOfService = .userInteractive
    return queue
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Temporary for testing registeration page
    // emailTextField.text     = "info@info.com"
    // passwordTextField.text  = "123456"
    // nameTextField.text      = "someExample"  
    
    nameTextField.isHidden = true
    loginButton.layer.cornerRadius = 5
    //passwordTextField.isSecureTextEntry = true - done through main storyboard
    
    //Looks for single or multiple taps.
    let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
    
    //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
    //tap.cancelsTouchesInView = false
    
    view.addGestureRecognizer(tap)
    
    nc.addObserver(self, selector: #selector(goToNotificationConnection), name: NSNotification.Name(rawValue: "notifacationFromConnect"), object: nil)
    
    nc.addObserver(self, selector: #selector(goToNotificationDisconnection), name: NSNotification.Name(rawValue: "notifacationFromDisconnect"), object: nil)
    
  }
  
  @objc func goToNotificationConnection(notification: Notification) {
    
    if let user: User = notification.object as? User {
      goToQuestionViewController(user: user)
    }
  }
  
  @objc func goToNotificationDisconnection(notification: Notification) {
    
    if let user: User = notification.object as? User, let typeConnect:User.TypeConnect = user.typeConnect {
      switch typeConnect {
      case .fb:
        let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
        fbLoginManager.logOut()
        break
      case .gplus:
        if let signIn = signIn {
          signIn.disconnect()
        }
        break
      case .vk:
        let service = VKService()
        service.token = ""
        break
      default:
        break
      }
    }
  }
  
  
  
  
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    
  }
  
  // MARK: Functions
  
  //Calls this function when the tap is recognized.
  @objc func dismissKeyboard() {
    //Causes the view (or one of its embedded text fields) to resign the first responder status.
    view.endEditing(true)
  }
  
  // MARK: IBAction functions
  
  /// Нажатие на сегмент выбора "Вход/Регистрация"
  @IBAction func tapLoginSegment(_ sender: Any) {
    if loginRegistrationSegment.selectedSegmentIndex == 0 {
      nameTextField.isHidden.toggle()
      loginButton.setTitle("Войти", for: .normal)
    }
    if loginRegistrationSegment.selectedSegmentIndex == 1 {
      nameTextField.isHidden.toggle()
      loginButton.setTitle("Зарегистрироваться", for: .normal)
    }
  }
  
  // Процесс Авторизации/Регистрации при нажатии на кнопку Войти/Зарегистрироваться
  @IBAction func tapEnterButton(_ sender: Any) {
    
    // Обозначение контролёра, к которому будет совершён переход по окончании автоизационного замыкания
    let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuestionListTableViewController") as! QuestionListTableViewController
    
    if nameTextField.isHidden {
      // Авторизация
      app.api.login(username: emailTextField.text!, password: passwordTextField.text!, completion: {
        magic("Completion successful")
        
        // Процесс перехода на указанный выше контролёр
        self.present(controller, animated:true, completion:nil)
      })
      
    } else {
      // Регистрация
      app.api.signup(email: emailTextField.text!, login: nameTextField.text!, password: passwordTextField.text!, completion: {
        magic("Registration successful")
        
        // Процесс перехода на указанный выше контролёр
        self.present(controller, animated: true, completion: nil)
      })
    }
    
    // TODO: credentials encoded in base64
    //    let username = emailTextField.text!
    //    let password = passwordTextField.text!
    //
    //    let Url = String(format: "http://cluck-app.org/api/auth/login")
    //    guard let serviceUrl = URL(string: Url) else { return }
    //
    //    // let loginParams = String(format: LOGIN_PARAMETERS1, "test", "Hi World")
    //
    //    let parameterDictionary = ["login" : username, "password" : password]
    //    var request = URLRequest(url: serviceUrl)
    //    request.httpMethod = "POST"
    //    request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
    //    guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
    //      return
    //    }
    //    request.httpBody = httpBody
    //
    //    let session = URLSession.shared
    //    session.dataTask(with: request) { (data, response, error) in
    //      if let response = response {
    //        magic(response)
    //      }
    //      if let data = data {
    //        do {
    //          let json = try JSONSerialization.jsonObject(with: data, options: [])
    //          magic(json)
    //        }catch {
    //          magic(error)
    //        }
    //      }
    //      }.resume()
  }
  
  /// Забыл пароль, друг?
  @IBAction func tapForgetPassButton(_ sender: Any) {}
  
  /*
   // MARK: - Navigation
   
   // In a storyboard-based application, you will often want to do a little preparation before navigation
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
   // Get the new view controller using segue.destinationViewController.
   // Pass the selected object to the new view controller.
   }
   */
  
  
}

extension LoginViewController {
  
  @IBAction func tapConnectGoogle(_ sender: Any) {
    googleSign()
    signIn?.signIn()
  }
  
  @IBAction func tapConnectFB(_ sender: AnyObject) {
    guard ((FBSDKAccessToken.current()) == nil) else {self.getFBUserData(); return}
    let fbLoginManager : FBSDKLoginManager = FBSDKLoginManager()
    fbLoginManager.logIn(withReadPermissions: ["public_profile", "email"], from: self) { (result, error) in
      if (error == nil){
        let fbloginresult : FBSDKLoginManagerLoginResult = result!
        if fbloginresult.grantedPermissions != nil {
          if(fbloginresult.grantedPermissions.contains("email"))
          {
            self.getFBUserData()
            //fbLoginManager.logOut()
          }
        }
      }
    }
  }
  
  func getFBUserData(){
    if((FBSDKAccessToken.current()) != nil){
      FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "id, name, first_name, last_name, picture.type(large), email"]).start(completionHandler: { (connection, result, error) -> Void in
        if (error == nil){
          let dict = result as! [String : AnyObject]
          if let user:User = User(dictForFB: dict) {
            self.nc.post(name: NSNotification.Name(rawValue: "notifacationFromConnect"), object: user)
          }
        }
      })
    }
  }
  
  func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
    if error != nil {
      print(error)
    }
    
    if let user = user {
      let gplusUser = User(gplusUser: user)
      self.nc.post(name: NSNotification.Name(rawValue: "notifacationFromConnect"), object: gplusUser)
    }
    
    let getCacheImage = GetCacheImage(url: ((user?.profile.imageURL(withDimension: 50))?.absoluteString)!)
    
    getCacheImage.main()
    
    //goToViewController(vc: "QuestionListTableViewController", user: user)
    
    if let outputImage = getCacheImage.outputImage {
      loginGoogleButton.setImage(outputImage, for: .normal)
      loginGoogleButton.imageView?.layer.cornerRadius = (outputImage.size.height / 2)
      //доделать через Class
      //                let setImageToRow = SetImageToElement(button: loginGoogleButton)
      //                setImageToRow.addDependency(getCacheImage)
      //                queue.addOperation(getCacheImage)
      //                OperationQueue.main.addOperation(setImageToRow)
    }
    
    
  }
  
  func googleSign() {
    
    signIn?.clientID = "603058356714-ocmggf18knpcm3icvknjn0ttnh27tlhn.apps.googleusercontent.com"
    signIn?.language = "ru"
    signIn?.uiDelegate = self
    signIn?.delegate = self
    
    if (signIn?.hasAuthInKeychain() == true) {
      signIn?.signIn()
    }
  }
  
  func goToQuestionViewController(user: User){
    let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "QuestionListTableViewController") as! QuestionListTableViewController
    QuestionsManager.sharedInstance.user = user
    self.present(vc, animated: true, completion: nil)
    
  }
  
}

extension LoginViewController: WKNavigationDelegate {
  
  @IBAction func tapConnectVK(_ sender: UIButton) {
    
    let viewBounds = self.view.bounds
    webView.frame = CGRect(x: viewBounds.minX, y: viewBounds.minY, width: viewBounds.maxX, height: viewBounds.maxY)
    webView.navigationDelegate = self
    
    let service = VKService()
    if service.token == "" {
      self.view.addSubview(webView)
    }
    if let request = service.vkAuthRequest()  {
      webView.load(request)
    }
    
  }
  
  func getUserVK(){
    
    let service = VKService()
    service.getUsers(token: service.token) {data, error in
      if let error = error {
        print(error)
        return
      }
      if let user = data {
        
        self.nc.post(name: NSNotification.Name(rawValue: "notifacationFromConnect"), object: user)
        
        let iconVK = user[0].logo
        let getCacheImage = GetCacheImage(url: iconVK)
        
        getCacheImage.main()
        
        if let outputImage = getCacheImage.outputImage {
          DispatchQueue.main.async {
            self.loginVKButton.setImage(outputImage, for: .normal)
            self.loginVKButton.imageView?.layer.cornerRadius = (outputImage.size.height / 2)
            self.goToQuestionViewController(user: user[0])
          }
          
          //доделать через Class
          //                let setImageToRow = SetImageToElement(button: loginGoogleButton)
          //                setImageToRow.addDependency(getCacheImage)
          //                queue.addOperation(getCacheImage)
          //                OperationQueue.main.addOperation(setImageToRow)
        }
        //self.goToViewController(vc: "QuestionListTableViewController")
        return
      }
      
    }
  }
  
  func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Swift.Void){
    guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment
      else {
        decisionHandler(.allow)
        return
    }
    let params = fragment
      .components(separatedBy: "&")
      .map { $0.components(separatedBy: "=") }
      .reduce([String: String]()) { result, param in
        var dict = result
        let key = param[0]
        let value = param[1]
        dict[key] = value
        return dict
    }
    if let token = params["access_token"]{
      print(token)
      let service = VKService()
      service.token  = token
      getUserVK()
    }
    
    webView.isHidden = true
    decisionHandler(.cancel)
    
  }
}
