//
//  JZViewController.swift
//  i行销
//
//  Created by Gordon on 2017/6/23.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import UIKit

class LYViewController: UIViewController, UIGestureRecognizerDelegate, LYRequestManagerDelegate {

    
    lazy var netMng: LYRequestManager = {
        let net = LYRequestManager()
        net.delegate = self
        return net
    }()
    lazy var animateView: UIActivityIndicatorView = {
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
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        SDImageCache.shared().clearMemory()
        SDImageCache.shared().setValue(nil, forKey: "memCache")
    }
    

    @objc func ly_startAnimating() {
        animateView.superview?.bringSubview(toFront: animateView)
        animateView.startAnimating()
    }
    @objc func ly_stopAnimating() {
        animateView.stopAnimating()
    }
    
    // MARK: - ********* Net Response delegate
    func lyNetworkReponseSucceed(urlStr: String, result: Dictionary<String, Any>?) {
    }
    func lyNetworkReponseIncorrect(code: Int, urlStr: String, message: String?) {
    }
    func lyNetworkReponseFailed(urlStr: String, error: LYError?) {
        
    }
}
