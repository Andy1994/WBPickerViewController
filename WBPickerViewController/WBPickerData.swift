//
//  WBPickerData.swift
//  WBPickerViewController_Example
//
//  Created by wangwenbo on 2019/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

public struct WBPickerData {
    
    public var key: String?
    public var data: Any?
    public var values: [WBPickerData]?
    
    public var numberOfComponents: Int {
        if let data = values?.first {
            return data.numberOfComponents + 1
        } else {
            return 1
        }
    }
    
    public init(key: String?, data: Any? = nil, values: [WBPickerData]? = nil) {
        self.key = key
        self.data = data
        self.values = values
    }
}
