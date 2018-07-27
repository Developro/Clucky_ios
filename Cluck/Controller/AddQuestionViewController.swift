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
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())

    }

    @objc func backButtonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
    
    // изящнее и короче решение для того, чтобы убрать клавиатуру по тапу, лишнее удалил
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
