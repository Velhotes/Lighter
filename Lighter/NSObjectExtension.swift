//
//  NSObjectExtension.swift
//  Lighter
//
//  Created by Rui Peres on 15/02/2016.
//  Copyright © 2016 Velhotes. All rights reserved.
//

import Foundation
import CoreFoundation

extension NSObject {
    
    class func swizzleMethodSelector(lhs: Selector, rhs: Selector, c: AnyClass) {
        
        let originalMethod = class_getInstanceMethod(self, lhs)
        let swizzledMethod = class_getInstanceMethod(self, rhs)
        
        let didAddMethod = class_addMethod(self, lhs, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(self, rhs, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod))
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    }
}
