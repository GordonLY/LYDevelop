//
//  LYNavBgView.swift
//  takeEasy
//
//  Created by Gordon on 2017/8/2.
//  Copyright © 2017年 Gordon. All rights reserved.
//

import UIKit

class LYNavBgView: UIView {
    
    enum bgLeftStyle {
        case back
        case close
    }
    enum bgRightStyle {
        case share
    }
    enum bgTitleStyle {
        case defaultStyle
        case custom(titleColor: UIColor, bgColor: UIColor)
    }
    
    private var leftAction: (() -> Void)
    private var rightAction: (() -> Void)?
    
    private(set) var title: String
    private(set) var leftView: UIButton!
    private(set) var titleLabel: UILabel!
    private(set) var rightView: UIButton!
    private(set) var line: UIView!
    
    init(title: String, leftAction: @escaping (() -> Void)) {
        self.title = title
        self.leftAction = leftAction
        let frame = CGRect(x: 0, y: 0, width: kScreenWid(), height: kNavBottom())
        super.init(frame: frame)
        p_initSubviews()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - ********* public method for style setting
extension LYNavBgView {
    func setLeftStyle(_ style: bgLeftStyle) {
        switch style {
        case .back:
            leftView.setImage(UIImage.init(named: "km_back"), for: .normal)
            leftView.setImage(UIImage.init(named: "km_back")?.ly.tintColor(kTitleColorHalf()), for: .highlighted)
        case .close:
            leftView.setImage(UIImage.init(named: "km_back"), for: .normal)
            leftView.setImage(UIImage.init(named: "km_back")?.ly.tintColor(kTitleColorHalf()), for: .highlighted)
        }
    }
    func setRightStyle(_ style: bgRightStyle, rightAction: (() -> Void)? = nil) {
        self.rightAction = rightAction
        switch style {
        case .share:
            rightView.setImage(UIImage.init(named: "share_icon"), for: .normal)
            rightView.setImage(UIImage.init(named: "share_icon")?.ly.tintColor( kTitleColorHalf()), for: .highlighted)
        }
        rightView.isHidden = false
    }
    func setTitleStyle(_ style: bgTitleStyle) {
        switch style {
        case .defaultStyle:
            titleLabel.textColor = kTitleColor()
            self.backgroundColor = UIColor.white
        case .custom(let titleColor,let bgColor):
            titleLabel.textColor = titleColor
            self.backgroundColor = bgColor
        }
    }
}

// MARK: - ********* response
extension LYNavBgView {
    
    @objc fileprivate func p_actionleftView() {
        leftAction()
    }
    @objc fileprivate func p_actionRightView() {
        rightAction?()
    }
}

extension LYNavBgView {
    
    fileprivate func p_initSubviews() {
        
        self.backgroundColor = UIColor.white
        
        line = UIView.init(frame: CGRect.init(x: 0, y: kNavBottom() - 0.5, width: kScreenWid(), height: 0.5))
        line.backgroundColor = kSeparateLineColor()
        self.addSubview(line)
        
        titleLabel = UILabel.init(frame: CGRect.init(x: 48, y: kNavTop(), width: kScreenWid() - 96, height: 44))
        titleLabel.textColor = kTitleColor()
        titleLabel.textAlignment = .center
        titleLabel.font = kStandardRegualrFont(size: 17)
        self.addSubview(titleLabel)
        
        leftView = UIButton.init(frame: CGRect.init(x: 0, y: kNavTop(), width: 48, height: 44))
        leftView.setImage(UIImage.init(named: "km_back"), for: .normal)
        leftView.setImage(UIImage.init(named: "km_back")?.ly.tintColor(kTitleColorHalf()), for: .highlighted)
        leftView.addTarget(self, action: #selector(p_actionleftView), for: .touchUpInside)
        self.addSubview(leftView)
        
        rightView = UIButton.init(frame: CGRect.init(x: kScreenWid() - 48, y: kNavTop(), width: 48, height: 44))
        rightView.setImage(UIImage.init(named: "share_icon"), for: .normal)
        rightView.setImage(UIImage.init(named: "share_icon")?.ly.tintColor( kTitleColorHalf()), for: .highlighted)
        rightView.isHidden = true
        rightView.addTarget(self, action: #selector(p_actionRightView), for: .touchUpInside)
        self.addSubview(rightView)
    }
}
