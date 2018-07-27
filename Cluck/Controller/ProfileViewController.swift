//
//  ProfileViewController.swift
//  Cluck
//
//  Created by Djaflienda on 26.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navBarBackground.png"), for: .default)
        navigationItem.leftBarButtonItem = NavigationButton.createNavigationButtonOf(type: .menuButton, with: #selector(SWRevealViewController.revealToggle(_:)), on: revealViewController())
        
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
        view.addSubview(NavigationButton.createCircleLogo(with: CGPoint(x: 50, y: 100), with: "profileImage"))
    }
}
