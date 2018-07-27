//
//  QuestionViewController.swift
//  Cluck
//
//  Created by Djaflienda on 27.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground.png"), for: .default)
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
}
