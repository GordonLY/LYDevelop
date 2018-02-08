//
//  LYNetProvider.swift
//  泰行销
//
//  Created by Gordon on 2017/12/6.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import Foundation

let kJZPageSize = 10
let devConfigJZ: DevelopEnvironment = .online

public enum DevelopEnvironment {
    /// 测试环境
    case test
    /// 线上环境
    case online
}

class LYNetProvider<Target: LYNetTargetType> {
    
    weak var delegate : LYNetProviderResponseProtocol?
    private var requestsArr: [URLSessionDataTask] = []
    
    func cancelAllRequest() { requestsArr.forEach {$0.cancel()}}
    deinit { requestsArr.forEach {$0.cancel()} }

    func request(_ target: Target, param: [String: Any]? = nil, success:(([String: Any]?) -> Void)? = nil, incorrect:((String?) -> Void)? = nil, fail:((Error?) -> Void)? = nil) {
        switch target.method {
        case .get:
            ly_getRequest(target: target, param: param, header: target.headers, success: success, incorrect: incorrect, fail: fail)
        case .post:
            ly_postRequest(target: target, param: param, header: target.headers, success: success, incorrect: incorrect, fail: fail)
        }
    }
    func loaclCache(_ target: Target, param: [String: Any] = [:]) -> [String: Any]? {
        let urlStr = target.baseURL + target.path
        return LYNetWork.ly_CacheDataFromeUrl(urlStr, dict: param) as? [String: Any]
    }
}

extension LYNetProvider {
    fileprivate func ly_getRequest(target:Target, param: [String: Any]?, header:[String: String], success:(([String: Any]?) -> Void)?, incorrect:((String?) -> Void)?, fail:((Error?) -> Void)?) {
        let needCache = target.needCache
        let urlStr = target.baseURL + target.path
        requestsArr.append(LYNetWork.ly_get(withUrl: urlStr, dict: param, needCache: needCache, header: header, success: { [weak self](responseObj) in
            guard let `self` = self else { return }
            LYToastView.hideLoading()
            if let result = responseObj as? [String: Any] {
                // success
                if let code = result["code"] as? Int, code == 0 {
                    self.delegate?.ly_netReponseSuccess(target: target, result: result)
                    success?(result)
                } else {
                    if let msg = result["msg"] as? String {
                        let resCode = (result["code"] as? Int) ?? 99999
                        self.delegate?.ly_netReponseIncorrect(code: resCode, target: target, message: msg)
                        incorrect?(msg)
                    }
                }
            }
        }) { (error) in
            LYToastView.hideLoading()
            self.delegate?.ly_netReponseFailed(target: target)
            fail?(error)
        })
    }
    ///  post request
    fileprivate func ly_postRequest(target:Target, param: [String: Any]?, header:[String: String], success:(([String: Any]?) -> Void)?, incorrect:((String?) -> Void)?, fail:((Error?) -> Void)?) {
        let urlStr = target.baseURL + target.path
        requestsArr.append(LYNetWork.ly_post(withUrl: urlStr, dict: param, header: header, success: { [weak self](responseObj) in
            guard let `self` = self else { return }
            LYToastView.hideLoading()
            if let result = responseObj as? [String: Any] {
                // success
                if let code = result["code"] as? Int, code == 0 {
                    self.delegate?.ly_netReponseSuccess(target: target, result: result)
                    success?(result)
                } else {
                    if let msg = result["msg"] as? String {
                        let resCode = (result["code"] as? Int) ?? 99999
                        self.delegate?.ly_netReponseIncorrect(code: resCode, target: target, message: msg)
                        incorrect?(msg)
                    }
                }
            }
        }) { (error) in
            LYToastView.hideLoading()
            self.delegate?.ly_netReponseFailed(target: target)
            fail?(error)
        })
    }
}



protocol LYNetProviderResponseProtocol: NSObjectProtocol {
    
    typealias Target = LYNetTargetType
    ///  请求成功
    func ly_netReponseSuccess(target: Target, result: [String: Any]?)
    ///  请求错误
    func ly_netReponseIncorrect(code: Int, target: Target, message: String?)
    ///  请求失败
    func ly_netReponseFailed(target: Target)
}


public protocol LYNetTargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// The HTTP method used in the request.
    var method: HTTPMethod { get }
    
    /// Cache dict to disk
    var needCache: Bool { get }
    
    /// The headers to be used in the request.
    var headers: [String: String] { get }
}

public enum HTTPMethod {
    case get
    case post
}



