//
//  NSObjectExtension.swift
//  ETOnboarding
//
//  Created by Eray Alparslan on 19.03.2020.
//  Copyright © 2020 Eray Alparslan. All rights reserved.
//

import Foundation

extension NSObject {
    var className: String {
        return type(of: self).className
    }

    static var className: String {
        return stringFromClass(aClass: self)
    }
}

func stringFromClass(aClass: AnyClass) -> String {
    return NSStringFromClass(aClass).components(separatedBy: ".").last!
}
