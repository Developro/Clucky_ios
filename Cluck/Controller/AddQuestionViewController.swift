//
//  AddQuestionViewController.swift
//  Cluck
//
//  Created by Наталья Синицына on 02.06.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class AddQuestionViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuBarButton = NavigationButton.createNavigationButtonOf(type: .menuButton, with: #selector(SWRevealViewController.revealToggle(_:)), on: revealViewController())
        let spacer = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        let backBarButton = NavigationButton.createNavigationButtonOf(type: .backButton, with: #selector(backButtonTapped), on: self)
        // нужно найти какой-то выход, чтобы не добавлять кучу spacer для промежутка между кнопками
        navigationItem.leftBarButtonItems = [backBarButton, spacer, spacer, spacer, menuBarButton]

        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddQuestionViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }

    //Calls this function when the tap is recognized.
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
