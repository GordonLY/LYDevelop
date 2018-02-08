//
//  LYBaseViewC.swift
//  takeEasy
//
//  Created by Gordon on 2017/8/2.
//  Copyright © 2017年 Gordon. All rights reserved.
//

import UIKit
import Kingfisher

class LYBaseViewC: UIViewController, UIGestureRecognizerDelegate {
    
    private lazy var animateView: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView.init(activityIndicatorStyle: .gray)
        indicator.centerX = self.view.centerX
        indicator.top = kFitWid(200)
        self.isLoadAnimate = true
        self.view.addSubview(indicator)
        return indicator
    }()
    private var isLoadAnimate = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
    }
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if isLoadAnimate {
            self.ly_stopAnimating()
        }
    }
    deinit {
        d_print("==== \(self) >>> dealloc ")
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        KingfisherManager.shared.cache.clearMemoryCache()
    }
    
    func ly_startAnimating() {
        animateView.superview?.bringSubview(toFront: animateView)
        animateView.startAnimating()
    }
    func ly_stopAnimating() {
        animateView.stopAnimating()
    }
}
