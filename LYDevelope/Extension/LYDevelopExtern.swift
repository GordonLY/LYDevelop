//
//  LYDevelopExtern.swift
//  kemiBear
//
//  Created by 李扬 on 2017/4/18.
//  Copyright © 2017年 李扬. All rights reserved.
//

import UIKit

final class LYDevelopExtern: NSObject {
    
    static let shared = LYDevelopExtern()
    private override init() {}
    
    public var lyScreenWidth: CGFloat {
        self.p_refreshIfNeeded()
        return screenWidth
    }
    public var lyScreenHeight: CGFloat {
        self.p_refreshIfNeeded()
        return screenHeight
    }
    public var lyScreenWidthRatio: CGFloat {
        self.p_refreshIfNeeded()
        return screenWidthRatio
    }
    public var lyScreenHeightRatio: CGFloat {
        self.p_refreshIfNeeded()
        return screenHeightRatio
    }
    

    private func p_refreshIfNeeded() {
        guard UIScreen.main.bounds.size.equalTo(CGSize(width: screenWidth, height: screenHeight)) else {
            self.p_refreshData()
            return
        }
    }

    //  默认参考size = (375,667)
    private let designSize = CGSize.init(width: 375, height: 667)
    private var screenWidth: CGFloat = 1
    private var screenHeight: CGFloat = 1
    private var screenWidthRatio: CGFloat = 1
    private var screenHeightRatio: CGFloat = 1
    private func p_refreshData() {
        screenWidth = UIScreen.main.bounds.size.width
        screenHeight = UIScreen.main.bounds.size.height
        screenWidthRatio = screenWidth / designSize.width
        screenHeightRatio = screenHeight / designSize.height
    }
}
