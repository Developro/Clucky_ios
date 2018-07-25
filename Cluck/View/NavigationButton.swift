//
//  NavigationButton.swift
//  Cluck
//
//  Created by Djaflienda on 25.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

enum NavigationButtonTypes: String {
    case menuButton = "hamburger-menu", filterButton = "filterButton", backButton = "arrow-left-in-circle", searchButton
}

class NavigationButton {
    
    static func createNavigationButtonOf(type: NavigationButtonTypes, with action: Selector, on target: Any?) -> UIBarButtonItem {
        let button = UIButton()
        button.setImage(UIImage(named: type.rawValue), for: .normal)
        button.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        button.addTarget(target, action: action, for: .touchUpInside)
        let item = UIBarButtonItem()
        item.customView = button
        return item
    }
    
    static func createMoreInfoButton(with coorditates: CGPoint, sized: CGSize, with action: Selector, on target: Any?) -> UIButton {
        let button = UIButton()
        button.setImage(UIImage(named: "moreInfo"), for: .normal)
        button.frame = CGRect(origin: coorditates, size: sized)
        button.addTarget(target, action: action, for: .touchUpInside)
        return button
    }
    
    //    static func createCategoriesButton(with action: Selector, on target: Any?) -> UIBarButtonItem {
    //        let button = UIButton()
    //        button.setTitle("Categories", for: .normal)
    //        button.frame = CGRect(origin: coorditates, size: sized)
    //        button.addTarget(target, action: action, for: .touchUpInside)
    //        return button
    //    }
    
    
}
