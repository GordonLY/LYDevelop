//
//  LYTabBarController.swift
//  rrliOS
//
//  Created by 李扬 on 2018/2/2.
//  Copyright © 2018年 李扬. All rights reserved.
//

import UIKit

class LYTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        p_initsubvc()
    }
}

extension LYTabBarController {
    
    fileprivate func p_initsubvc() {
        let recommend = KMRecommendViewC()
        self.p_addChildVc(childVc: recommend, title: "推荐", image: "tabbar_recommend_nor", selectedImage: "tabbar_recommend_sel")
        
        let historyAct = KMHistoryActListVC()
        self.p_addChildVc(childVc: historyAct, title: "发现", image: "tabbar_activity_nor", selectedImage: "tabbar_activity_sel")
        
        let myProfile = KMProfileViewC()
        self.p_addChildVc(childVc: myProfile, title: "我的", image: "tabbar_mine_nor", selectedImage: "tabbar_mine_sel")
        
        
        self.tabBar.backgroundColor = UIColor.red
        self.tabBar.backgroundImage = UIImage()
    }

    private func p_addChildVc(childVc:UIViewController, title: String, image: String, selectedImage: String) {
        
        childVc.title = title
        childVc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:kStandardRegualrFont(size: 9),NSForegroundColorAttributeName:UIColor.colorRGBA(0x33363a, 1)], for: .normal)
        childVc.tabBarItem.setTitleTextAttributes([NSFontAttributeName:kStandardRegualrFont(size: 9),NSForegroundColorAttributeName:UIColor.colorRGBA(0x33363a, 1)], for: .selected)
        childVc.tabBarItem.image = UIImage.init(named: image)?.withRenderingMode(.alwaysOriginal)
        childVc.tabBarItem.selectedImage = UIImage.init(named: selectedImage)?.withRenderingMode(.alwaysOriginal)
        
        let navVC = KMNavigationController.init(rootViewController: childVc)
        self.addChildViewController(navVC)
    }
}
