//
//  LYHitTestScrollView.swift
//  泰行销
//
//  Created by Gordon on 2017/7/28.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import UIKit

class LYHitTestScrollView: UIScrollView {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        guard let currentView = view else {
            return view
        }
        if currentView.isKind(of: UITextView.self) || currentView.isKind(of: UITextField.self) {
            return currentView
        } else {
            self.endEditing(true)
            return view
        }
    }
}
