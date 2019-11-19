//
//  WBPickerView.swift
//  WBPickerViewController_Example
//
//  Created by wangwenbo on 2019/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

class WBPickerView: UIPickerView {

    public var data = [WBPickerData]() {
        didSet {
            if data.first?.numberOfComponents ?? 0 > 2 {
                componentWidth = 100
            } else {
                reloadAllComponents()
            }
            for component in 0 ..< numberOfComponents(in: self)  {
                selectRow(0, inComponent: component, animated: false)
            }
        }
    }
    
    public var selectedPickerDataBlock: (([WBPickerData]) -> Void)?
    
    // component width
    public var componentWidth: CGFloat = 140 {
        didSet {
            reloadAllComponents()
        }
    }
    
    // component height
    public var componentHeight: CGFloat = 30 {
        didSet {
            reloadAllComponents()
        }
    }
    
    // Font to be used for all rows
    public var font = UIFont.systemFont(ofSize: 25) {
        didSet {
            reloadAllComponents()
        }
    }
    
    // component text color, default is nil (text draws black)
    public var textColor: UIColor? {
        didSet {
            reloadAllComponents()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        delegate = self
        dataSource = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WBPickerView: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return data.first?.numberOfComponents ?? 0
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        var depth = 0
        var pickerData = data
        while !pickerData.isEmpty {
            if depth == component {
                return pickerData.count
            } else {
                pickerData = pickerData[safe: selectedRow(inComponent: depth)]?.values ?? []
                depth += 1
            }
        }
        return 0
    }
}

extension WBPickerView: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, widthForComponent component: Int) -> CGFloat {
        return componentWidth
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return componentHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: componentWidth, height: componentHeight))
        label.adjustsFontSizeToFitWidth = true
        label.textAlignment = .center
        label.font = font
        label.textColor = textColor
        label.text = stringForRow(row, forComponent: component)
        return label
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if numberOfComponents(in: pickerView) > component + 1 {
            reloadComponent(component + 1)
            selectRow(0, inComponent: component + 1, animated: false)
        }
        // 有三列的情况下显示第三列
        if numberOfComponents(in: pickerView) > component + 2 {
            reloadComponent(component + 2)
            selectRow(0, inComponent: component + 2, animated: false)
        }
    }
}

extension WBPickerView {
    
    func stringForRow(_ row: Int, forComponent component: Int) -> String? {
        var depth = 0
        var pickerData = data
        while !pickerData.isEmpty {
            if depth == component {
                return pickerData[safe: row]?.key
            } else {
                pickerData = pickerData[safe: selectedRow(inComponent: depth)]?.values ?? []
                depth += 1
            }
        }
        return nil
    }
    
    func pickerViewDidSelected() {
        guard numberOfComponents > 0 else {
            return
        }
        var pickerData = data
        var pickerDatas = [WBPickerData]()
        for component in 0 ..< numberOfComponents {
            let row = selectedRow(inComponent: component)
            if let model = pickerData[safe: row] {
                if let values = model.values {
                    pickerData = values
                }
                pickerDatas.append(model)
            }
        }
        selectedPickerDataBlock?(pickerDatas)
    }
}
