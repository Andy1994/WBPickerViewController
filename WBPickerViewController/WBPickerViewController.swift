//
//  WBPickerViewController.swift
//  WBPickerViewController_Example
//
//  Created by wangwenbo on 2019/11/19.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit

protocol WBPickerViewControllerDelegate: class {
    func pickerInputViewControllerDidChanged(_ identity: String?, pickerDatas: [WBPickerData]?)
}

class WBPickerViewController: UIViewController {

    // 代理
    public weak var delegate: WBPickerViewControllerDelegate?
    
    // 唯一标识符
    public var identity: String?
    
    // PickerView 数据
    public var pickerDatas = [WBPickerData]() {
        didSet {
            pickerView.data = pickerDatas
        }
    }
    
    // 默认选中数组
    public var defaultSelectedArray = [Int]()
    
    // 自定义 present 动画
    public func presentFromViewController(_ viewController: UIViewController?) {
        modalPresentationStyle = .custom
        transitioningDelegate = alertTransition
        viewController?.present(self, animated: true, completion: nil)
    }
    
    public init(identity: String? = nil,
                pickerDatas: [WBPickerData] = [],
                defaultSelectedArray: [Int] = [],
                delegate: WBPickerViewControllerDelegate? = nil)
    {
        super.init(nibName: nil, bundle: nil)
        self.identity = identity
        self.defaultSelectedArray = defaultSelectedArray
        self.delegate = delegate
        defer {
            self.pickerDatas = pickerDatas
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public var backgroundView: UIView!
    public var contentView: UIView!
    public var accessoryView: UIView!
    public let pickerView = WBPickerView()
    public var bottomSafeView: UIView!
    
    private var isFirstViewDidAppear = true
    
    private let alertTransition = Transition.alertTransition()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if isFirstViewDidAppear {
            isFirstViewDidAppear = false
            loadPickerDefaultSelectedArray()
            UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
                self.backgroundView.alpha = 1
                self.contentView.y = self.view.height - self.bottomSafeView.bottom
            }, completion: nil)
        }
    }
    
    func loadPickerDefaultSelectedArray() {
        guard !defaultSelectedArray.isEmpty else {
            return
        }
        guard let numOfComponent = pickerDatas.first?.numberOfComponents, numOfComponent != 0 else {
            return
        }
        for component in 0 ..< numOfComponent {
            // 延迟让 reloadComponent 能显示正确内容
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.05 * (Double(component) + 1)) {
                self.pickerView.selectRow(self.defaultSelectedArray[safe: component] ?? 0, inComponent: component, animated: false)
                if component + 1 < numOfComponent {
                    self.pickerView.reloadComponent(component + 1)
                }
            }
        }
    }
    
    func setupSubviews() {
        backgroundView = UIView(frame: view.bounds)
        backgroundView.alpha = 0
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        backgroundView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissPickView)))
        view.addSubview(backgroundView)
        
        contentView = UIView(frame: CGRect(x: 0, y: view.height, width: view.width, height: view.height))
        view.addSubview(contentView)
        
        accessoryView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.width, height: 50))
        contentView.backgroundColor = UIColor.white
        contentView.addSubview(accessoryView)
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: contentView.width, height: 1.0 / UIScreen.main.scale))
        lineView.backgroundColor = UIColor(red: 237.0 / 255.0, green: 232.0 / 255.0, blue: 232.0 / 255.0, alpha: 1)
        contentView.addSubview(lineView)
        
        let cancelButton = UIButton(frame: CGRect(x: 0, y: 0, width: 81, height: 50))
        cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        cancelButton.setTitle("取消", for: .normal)
        cancelButton.setTitleColor(UIColor(red: 89.0 / 255.0, green: 61.0 / 255.0, blue: 61.0 / 255.0, alpha: 1), for: .normal)
        cancelButton.addTarget(self, action: #selector(cancelButtonPressed(_:)), for: .touchUpInside)
        contentView.addSubview(cancelButton)
        
        let doneButton = UIButton(frame: CGRect(x: UIScreen.width - 81, y: 0, width: 81, height: 50))
        doneButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        doneButton.setTitle("确定", for: .normal)
        doneButton.setTitleColor(UIColor(red: 89.0 / 255.0, green: 61.0 / 255.0, blue: 61.0 / 255.0, alpha: 1), for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
        contentView.addSubview(doneButton)
        
        pickerView.selectedPickerDataBlock = { [weak self] (pickerDatas) in
            self?.delegate?.pickerInputViewControllerDidChanged(self?.identity, pickerDatas: pickerDatas)
        }
        pickerView.y = accessoryView.bottom
        pickerView.width = UIScreen.width
        contentView.addSubview(pickerView)
        
        bottomSafeView = UIView(frame: CGRect(x: 0, y: pickerView.bottom, width: contentView.width, height: UIScreen.iPhoneXSafeAreaBottom))
        contentView.addSubview(bottomSafeView)
    }
    
    @objc func cancelButtonPressed(_ sender: Any) {
        dismissPickView()
    }
    
    @objc func doneButtonPressed(_ sender: Any) {
        pickerView.pickerViewDidSelected()
        dismissPickView()
    }
    
    @objc func dismissPickView() {
        UIView.animate(withDuration: 0.25, delay: 0, options: [.curveEaseOut], animations: {
            self.backgroundView.alpha = 0
            self.contentView.y = self.view.height
        }) { (_) in
            self.dismiss(animated: true, completion: nil)
        }
    }
}
