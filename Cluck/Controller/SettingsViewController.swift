//
//  SettingsViewController.swift
//  Cluck
//
//  Created by Djaflienda on 27.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground.png"), for: .default)
        navigationItem.leftBarButtonItem = NavigationButton.createNavigationButtonOf(type: .menuButton, with: #selector(SWRevealViewController.revealToggle(_:)), on: revealViewController())
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
    }
}
