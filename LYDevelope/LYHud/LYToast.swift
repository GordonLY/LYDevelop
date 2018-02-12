//
//  LYToast.swift
//  rrliOS
//
//  Created by Gordon on 2018/2/8.
//  Copyright © 2018年 rrl360. All rights reserved.
//

import UIKit
import Toaster

final class LYToast {
    private static var toast = Toast.init(text: "", duration: 1.5)
    class func show(tips: String, bottomOffset: CGFloat = 30) {
        if toast.isExecuting,
            tips == toast.text ?? "" { return }
        toast.cancel()
        toast.text = tips
        toast = Toast.init(text: tips, duration: 1.5)
        toast.view.font = kRegularFitFont(size: 13)
        toast.view.bottomOffsetPortrait = bottomOffset
        toast.show()
    }
}
