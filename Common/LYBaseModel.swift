//
//  LYBaseModel.swift
//  泰行销
//
//  Created by Gordon on 2017/12/4.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import UIKit

class LYBaseModel: NSObject {
    
    weak var vc: UIViewController?
    lazy var netMng: LYNetProvider<JZNetWork> = {
        let net = LYNetProvider<JZNetWork>()
        net.delegate = self
        return net
    }()
}
