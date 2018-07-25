//
//  RootViewController.swift
//  Cluck
//
//  Created by Djaflienda on 25.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    var sideMenuIsOpen = false
    
    @IBOutlet weak var viewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var mainViewContainer: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(toggleSideMenu), name: NSNotification.Name("ToggleSideMenu"), object: nil)
    }
    
    @objc func toggleSideMenu() {

        if sideMenuIsOpen {
            viewTrailingConstraint.constant = 0
            sideMenuIsOpen = false
        } else {
            viewTrailingConstraint.constant = -200
            sideMenuIsOpen = true
        }
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
        
    }
    
}
