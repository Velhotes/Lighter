//
//  Logger.swift
//  Lighter
//
//  Created by Rui Peres on 15/02/2016.
//  Copyright © 2016 Velhotes. All rights reserved.
//

import UIKit

struct Logger {
    
    private static func log(level: Int, viewController: UIViewController) {
        
        var paddingItems = "";
        
        for _ in 0..<level {
            
            paddingItems.appendContentsOf("--")
        }
        
        let infoLevel = String(format: "%@-> %@", arguments: [paddingItems, viewController.description])
        print(infoLevel)
    }
    
    static func printPath(viewController: UIViewController) {
        
        let parentViewController = viewController.parentViewController
            
        switch parentViewController {
            
        case _ where parentViewController?.isMemberOfClass(UINavigationController.self) != nil:
            
            guard
                let navigationController = parentViewController as? UINavigationController,
                let index = navigationController.viewControllers.indexOf(viewController)
            else {
                return
            }
            
            log(index, viewController: viewController)
            
        case _ where parentViewController?.isMemberOfClass(UITabBarController.self) != nil:
            
            log(1, viewController: viewController)
            
        case _ where parentViewController != nil: fallthrough
        default:
            log(0, viewController: viewController)
        }
    }
}
