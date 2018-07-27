//
//  NavigationButton.swift
//  Cluck
//
//  Created by Djaflienda on 25.07.2018.
//  Copyright © 2018 Наталья Синицына. All rights reserved.
//

import UIKit

enum NavigationButtonTypes: String {
    case menuButton = "hamburger-menu", filterButton = "filterButton", backButton = "arrow-left-in-circle", searchButton, askQuestion = "askQuestion"
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
    
//    static func createMoreInfoButton(with coorditates: CGPoint, sized: CGSize, with action: Selector, on target: Any?) -> UIButton {
//        let button = UIButton()
//        button.setImage(UIImage(named: "moreInfo"), for: .normal)
//        button.frame = CGRect(origin: coorditates, size: sized)
//        button.addTarget(target, action: action, for: .touchUpInside)
//        return button
//    }
    
    //    static func createCategoriesButton(with action: Selector, on target: Any?) -> UIBarButtonItem {
    //        let button = UIButton()
    //        button.setTitle("Categories", for: .normal)
    //        button.frame = CGRect(origin: coorditates, size: sized)
    //        button.addTarget(target, action: action, for: .touchUpInside)
    //        return button
    //    }
    
    static func createCircleLogo(with coordinates: CGPoint, with image: String) -> UIImageView {
        let borderCircle = UIImageView(frame: CGRect(origin: coordinates, size: CGSize(width: 145, height: 145)))
        borderCircle.backgroundColor = UIColor.white
        borderCircle.layer.opacity = 0.5
        borderCircle.layer.cornerRadius = 72.5
        
//        let x = borderCircle.frame.origin.x
//        let y = borderCircle.frame.origin.y
        
        let imageInsideBorderCircle = UIImageView(frame: CGRect(origin: CGPoint(x: 2.5, y: 2.5) , size: CGSize(width: 140, height: 140)))
//        imageInsideBorderCircle.backgroundColor = UIColor(patternImage: UIImage(named: image)!)
        imageInsideBorderCircle.backgroundColor = UIColor.red
        imageInsideBorderCircle.layer.cornerRadius = 70
        borderCircle.addSubview(imageInsideBorderCircle)
        return borderCircle
    }
    
    
}
