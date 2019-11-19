//
//  WBHelper.swift
//  WBPickerViewController_Example
//
//  Created by wangwenbo on 2019/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

extension Collection {
    /// Returns the element at the specified index if it is within bounds, otherwise nil.
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UIScreen {
    
    static var width: CGFloat {
        get {
            return main.bounds.size.width
        }
    }

    static var height: CGFloat {
        get {
            return main.bounds.size.height
        }
    }
    
    static var iPhoneXSafeAreaBottom: CGFloat {
        guard #available(iOS 11.0, *) else {
            return 0.0
        }
        return UIApplication.shared.windows[0].safeAreaInsets.bottom
    }
}

extension UIView {
    
    var x: CGFloat {
        get {
            return frame.origin.x
        }
        set(x) {
            var frame: CGRect = self.frame
            frame.origin.x = x
            self.frame = frame
        }
    }
    
    var y: CGFloat {
        get {
            return frame.origin.y
        }
        set(y) {
            var frame: CGRect = self.frame
            frame.origin.y = y
            self.frame = frame
        }
    }
    
    var right: CGFloat {
        get {
            return frame.origin.x + frame.size.width
        }
        set(right) {
            var frame: CGRect = self.frame
            frame.origin.x = right - frame.size.width
            self.frame = frame
        }
    }
    
    var bottom: CGFloat {
        get {
            return frame.origin.y + frame.size.height
        }
        set(bottom) {
            var frame: CGRect = self.frame
            frame.origin.y = bottom - frame.size.height
            self.frame = frame
        }
    }
    
    var centerX: CGFloat {
        get {
            return center.x
        }
        set(centerX) {
            center = CGPoint(x: centerX, y: center.y)
        }
    }
    
    var centerY: CGFloat {
        get {
            return center.y
        }
        set(centerY) {
            center = CGPoint(x: center.x, y: centerY)
        }
    }
    
    var width: CGFloat {
        get {
            return frame.size.width
        }
        set(width) {
            var frame: CGRect = self.frame
            frame.size.width = width
            self.frame = frame
        }
    }
    
    var height: CGFloat {
        get {
            return frame.size.height
        }
        set(height) {
            var frame: CGRect = self.frame
            frame.size.height = height
            self.frame = frame
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set(origin) {
            var frame: CGRect = self.frame
            frame.origin = origin
            self.frame = frame
        }
    }
    
    var size: CGSize {
        get {
            return frame.size
        }
        set(size) {
            var frame: CGRect = self.frame
            frame.size = size
            self.frame = frame
        }
    }
}
