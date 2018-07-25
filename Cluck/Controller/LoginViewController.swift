import UIKit
import Magic

class LoginViewController: UIViewController {
  
  //Outlets
  
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Temporary for testing registeration page
        // emailTextField.text     = "info@info.com"
        // passwordTextField.text  = "123456"
        // nameTextField.text      = "someExample"
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground.png"), for: .default)
        
        navigationItem.rightBarButtonItem = NavigationButton.createNavigationButtonOf(type: .menuButton, with: #selector(menuPressed), on: self)
        
        nameTextField.attributedPlaceholder = NSAttributedString(string: "Username", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedStringKey.foregroundColor : UIColor.white])
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func menuPressed() {
        //убрать в другой класс
        //пока заглушка
        NotificationCenter.default.post(name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    // MARK: Functions
  
    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
  
    // MARK: IBAction functions

    // Процесс Авторизации/Регистрации при нажатии на кнопку Войти/Зарегистрироваться
    @IBAction func tapEnterButton(_ sender: Any) {
    
        // Обозначение контролёра, к которому будет совершён переход по окончании автоизационного замыкания
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuestionListTableViewController") as! QuestionListTableViewController

        if nameTextField.isHidden {
            // Авторизация
            app.api.login(username: nameTextField.text!, password: passwordTextField.text!, completion: {
                magic("Completion successful")
        
            // Процесс перехода на указанный выше контролёр
            self.present(controller, animated:true, completion:nil)
            })
      
        } else {
            // Регистрация
            app.api.signup(email: nameTextField.text!, login: nameTextField.text!, password: passwordTextField.text!, completion: {
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
