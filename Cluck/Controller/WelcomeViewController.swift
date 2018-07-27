//
//  WelcomeViewController.swift
//  Cluck
//
//  Created by Djaflienda on 25.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

       view.addSubview(NavigationButton.createCircleLogo(with: CGPoint(x: view.frame.width / 2 - 75, y: 100), with: ""))
    }

}
