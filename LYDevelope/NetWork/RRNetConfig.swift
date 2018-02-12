//
//  RRNetConfig.swift
//  rrliOS
//
//  Created by Gordon on 2018/2/7.
//  Copyright © 2018年 rrl360. All rights reserved.
//

import Foundation



extension RRNetConfig: LYNetTargetType {
    
    public var baseURL: String {
        switch devConfig {
        case .test:
            return "http://sspuat.life.taikang.com"
        case .online:
            return "https://ssp.taikang.com"
        }
    }
    public var path: String {
        switch self {
        /// get
        case .productCenter:
            return "/prd/ProductCenter/getHkListB"
            
        /// post
        case .omList:
            return "/preservation/oml/getModuleList"
            
        }
    }
    public var urlStr: String {
        return baseURL + path
    }
    public var method: LYHTTPMethod {
        switch self {
        case .omList:
            return .post
        default:
            return .get
        }
    }
    var needCache: Bool {
        switch self {
        case .omList:
            return true
        default:
            return false
        }
    }
    var headers: [String : String] {
        switch devConfig {
        case .test:
            return ["token": "fdasfasdfasdfda"]
        case .online:
            return ["token": "fdasfasdfasdfda"]
        }
    }
//    public var needAlert: Bool {
//        switch self {
//        case .omList:
//            return true
//        default:
//            return false
//        }
//    }
}

enum RRNetConfig {
    /// 标签列表
    case omList
    /// 获客center
    case productCenter
}


