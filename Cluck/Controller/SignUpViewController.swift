//
//  SignUpViewController.swift
//  Cluck
//
//  Created by Djaflienda on 25.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit
import Magic

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func tapSignUpButton(_ sender: Any) {
        // Обозначение контролёра, к которому будет совершён переход по окончании автоизационного замыкания
//        let controller = self.storyboard?.instantiateViewController(withIdentifier: "") as! RootViewController
        
        // Регистрация
        app.api.signup(email: emailTextField.text!, login: nameTextField.text!, password: passwordTextField.text!, completion: {
            magic("Registration successful")
        
            // Процесс перехода на указанный выше контролёр
//            self.present(controller, animated: true, completion: nil)
        })
    }
}
