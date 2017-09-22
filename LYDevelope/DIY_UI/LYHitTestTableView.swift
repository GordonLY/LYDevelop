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
        if currentView.isKind(of: UITextView.self) || currentView.isKind(of: UITextField.self) ||
            currentView.isKind(of: UIButton.self) {
            return currentView
        } else {
            self.endEditing(true)
            return currentView
        }
    }
}
