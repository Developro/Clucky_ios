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
    
    let buttonsBehavior = ButtonsBehavior()

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground.png"), for: .default)
        
        navigationItem.rightBarButtonItem = NavigationButton.createNavigationButtonOf(type: .menuButton, with: #selector(buttonsBehavior.menuPressed), on: self)
    }
    
    @IBAction func tapSignUpButton(_ sender: Any) {
        
        // Обозначение контролёра, к которому будет совершён переход по окончании автоизационного замыкания
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "QuestionListTableViewController") as! QuestionListTableViewController
        
        // Регистрация
        app.api.signup(email: emailTextField.text!, login: nameTextField.text!, password: passwordTextField.text!, completion: {
            magic("Registration successful")
        
            // Процесс перехода на указанный выше контролёр
            self.present(controller, animated: true, completion: nil)
        })
    }


}
