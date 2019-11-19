//
//  ViewController.swift
//  WBPickerViewController
//
//  Created by Andy1994 on 11/19/2019.
//  Copyright (c) 2019 Andy1994. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button1: UIButton!
    var button2: UIButton!
    var button3: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    func setupSubviews() {
        button1 = UIButton(frame: CGRect(x: 0, y: 100, width: UIScreen.main.bounds.size.width, height: 50))
        button1.setTitleColor(UIColor.black, for: .normal)
        button1.setTitle("一列选择", for: .normal)
        button1.addTarget(self, action: #selector(showOnePickerViewController), for: .touchUpInside)
        view.addSubview(button1)
        
        button2 = UIButton(frame: CGRect(x: 0, y: 250, width: UIScreen.main.bounds.size.width, height: 50))
        button2.setTitleColor(UIColor.black, for: .normal)
        button2.setTitle("两列地址选择", for: .normal)
        button2.addTarget(self, action: #selector(showTwoPickerViewController), for: .touchUpInside)
        view.addSubview(button2)
        
        button3 = UIButton(frame: CGRect(x: 0, y: 400, width: UIScreen.main.bounds.size.width, height: 50))
        button3.setTitleColor(UIColor.black, for: .normal)
        button3.setTitle("三列地址选择", for: .normal)
        button3.addTarget(self, action: #selector(showThreePickerViewController), for: .touchUpInside)
        view.addSubview(button3)
    }
    
    // 展示一列
    @objc func showOnePickerViewController() {
        var keys = [String]()
        for number in 140 ... 210 {
            keys.append("\(number)cm")
        }
        // 默认选中170，170 - 140 = 30
        let vc = WBPickerViewController(identity: "height", pickerDatas: commonGeneratePickerData(keys), defaultSelectedArray: [30], delegate: self)
        vc.presentFromViewController(self)
    }
    
    // 展示两列
    @objc func showTwoPickerViewController() {
        // 默认省:天津，城市:天津
        let vc = WBPickerViewController(identity: "address two", pickerDatas: Helper.address()!, defaultSelectedArray: [1, 0], delegate: self)
        vc.presentFromViewController(self)
    }
    
    // 展示三列
    @objc func showThreePickerViewController() {
        var pickerDatas = [WBPickerData]()
        pickerDatas.append(WBPickerData(key: "有地址", values: Helper.address()!))
        pickerDatas.append(WBPickerData(key: "无地址", values: [WBPickerData(key: "", values: [WBPickerData(key: "")])]))
        // 默认有地址 省:天津，城市:天津
        let vc = WBPickerViewController(identity: "height three", pickerDatas: pickerDatas, defaultSelectedArray: [0, 1, 0], delegate: self)
        vc.presentFromViewController(self)
    }
    
    func commonGeneratePickerData(_ keys: [String]) -> [WBPickerData] {
        var results = [WBPickerData]()
        for key in keys {
            results.append(WBPickerData(key: key))
        }
        return results
    }
}

extension ViewController: WBPickerViewControllerDelegate {
    func pickerInputViewControllerDidChanged(_ identity: String?, pickerDatas: [WBPickerData]?) {
        print("\(identity ?? "") \(pickerDatas ?? [])")
        if identity == "height" {
            button1.setTitle("选中的身高为：\(pickerDatas?.first?.key ?? "nil")", for: .normal)
        } else if identity == "address two" {
            button1.setTitle("2.选中的地址为：\(pickerDatas?.last?.key ?? "nil") id:\(pickerDatas?.last?.data ?? "nil")", for: .normal)
        } else if identity == "address three" {
            button1.setTitle("3.选中的地址为：\(pickerDatas?.last?.key ?? "nil") id:\(pickerDatas?.last?.data ?? "nil")", for: .normal)
        }
    }
}

