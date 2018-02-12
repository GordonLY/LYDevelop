//
//  LYHud.swift
//  rrliOS
//
//  Created by Gordon on 2018/2/8.
//  Copyright © 2018年 rrl360. All rights reserved.
//

import UIKit
import MBProgressHUD

final class LYHud {
    
    /// showView need set when view is presented
    class func showLoading(on showView: UIView = getCurrentView()) {
        
        let hud = MBProgressHUD.init(view: showView)
        hud.bezelView.alpha = 1
        hud.bezelView.layer.cornerRadius = 10
        hud.bezelView.color = UIColor.init(white: 0, alpha: 0.8)
        hud.bezelView.style = .solidColor
        
        if #available(iOS 9.0, *) {
            UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MBProgressHUD.self]).color = UIColor.white
        } else {
            hud.activityIndicatorColor = UIColor.white
        }
        hud.removeFromSuperViewOnHide = true
        hud.animationType = .fade
        showView.addSubview(hud)
        DispatchQueue.main.async {
            hud.show(animated: true)
        }
    }
    /// hideView need set when view is presented
    class func hideLoading(on hideView: UIView = getCurrentView()) {
        let hideView = getCurrentView()
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: hideView, animated: true)
        }
    }
    
    private class func getCurrentView() -> UIView {
        let rootVc = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController
        let selVc = rootVc?.selectedViewController as? UINavigationController
        let view = selVc?.viewControllers.last?.view
        return view ?? UIApplication.shared.keyWindow!
    }
}
