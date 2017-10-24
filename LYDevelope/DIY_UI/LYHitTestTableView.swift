//
//  LYHitTestTableView.swift
//  i行销
//
//  Created by Gordon on 2017/7/4.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import UIKit

class LYHitTestTableView: LYTableView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard let currentView = view else {
            return view
        }
        /// fit iOS8
        if LYKeyBoardStatus.shared.keyboardRect.contains(point) {
            return view
        }
        if currentView.isKind(of: UITextView.self) || currentView.isKind(of: UITextField.self) ||
            currentView.isKind(of: UIButton.self) {
            return currentView
        } else {
            self.endEditing(true)
            return currentView
        }
    }
}

class LYKeyBoardStatus: NSObject {
    
    var keyboardRect = CGRect.zero
    
    static let shared = LYKeyBoardStatus()
    private override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidShow(noti:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyBoardDidHide), name: .UIKeyboardDidHide, object: nil)
    }
    @objc private func keyBoardDidShow(noti: Notification) {
        if let dict = noti.userInfo,
            let keybRect = dict[UIKeyboardFrameEndUserInfoKey] as? CGRect {
            keyboardRect = keybRect
        }
    }
    @objc private func keyBoardDidHide() {
        keyboardRect = .zero
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
