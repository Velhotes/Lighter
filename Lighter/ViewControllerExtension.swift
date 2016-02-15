//
//  ViewControllerExtension.swift
//  Lighter
//
//  Created by Rui Peres on 15/02/2016.
//  Copyright © 2016 Velhotes. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    private static var isSwizzled: Bool = false
    private static let lock = dispatch_queue_create("swizzling.lock", DISPATCH_QUEUE_SERIAL)
    
   public static func startLogging() {
        
        dispatch_sync(lock) {
            
            guard isSwizzled == false else { return }
            swizzleMethodSelector("viewWillAppear:", rhs: "swizzviewDidAppear:", c: UIViewController.self)
            isSwizzled = true
        }
    }
    
   public static func stopLogging() {
        
        dispatch_sync(lock) {
            
            guard isSwizzled == true else { return }
            swizzleMethodSelector("swizzviewDidAppear:", rhs: "viewWillAppear:", c: UIViewController.self)
            isSwizzled = false
        }
    }
    
   func swizzviewDidAppear(animated: Bool) {
        
        Logger.printPath(self)
        swizzviewDidAppear(animated)
    }
}

