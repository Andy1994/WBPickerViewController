//
//  Helper.swift
//  WBPickerViewController_Example
//
//  Created by wangwenbo on 2019/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

struct Address: Codable {
    var id: String?
    var name: String?
    var cities: [Address]?
}

class Helper: NSObject {
    
    static var addresses: [Address]?
    
    class func address() -> [WBPickerData]? {
        loadAddressIfNeeded()
        if let addresses = addresses {
            var result = [WBPickerData]()
            addresses.forEach { (address) in
                var cityArray = [WBPickerData]()
                if let cities = address.cities {
                    cities.forEach({ (address) in
                        cityArray.append(WBPickerData(key: address.name, data: address.id))
                    })
                }
                result.append(WBPickerData(key: address.name, data: address.id, values: cityArray))
            }
            return result
        } else {
            return nil
        }
    }
    
    class func loadAddressIfNeeded() {
        if addresses == nil {
            do {
                if let addressData = loadJsonData("address") {
                    addresses = try JSONDecoder().decode([Address].self, from: addressData)
                }
            }
            catch {
                print("Decoder Region Error: \(error)")
            }
        }
    }
    
    class func loadJsonData(_ fileName: String) -> Data? {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        return data
    }
}
