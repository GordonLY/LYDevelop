//
//  LYNetProvider.swift
//  泰行销
//
//  Created by Gordon on 2017/12/6.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import Foundation
import Alamofire

let kPageSize = 10

///  netWork Config
let kNetWorkDataCache = "NetWorkDataCache"
let kCacheDataSaveTimeLong: TimeInterval = 60 * 60 * 6 // 半天
let kCacheDataSaveTimeShort: TimeInterval = 60 * 30 // 半小时

class LYNetProvider<Target: LYNetTargetType> {
    
    private var requestsArr = [DataRequest]()
    
    func cancelAllRequest() { requestsArr.forEach {$0.cancel()}}
    deinit { requestsArr.forEach {$0.cancel()} }
}

extension LYNetProvider {
    // MARK: === net request
    func request(_ target: Target, param: [String: Any]? = nil, success:(([String: Any]?) -> Void)? = nil, incorrect:((String, String) -> Void)? = nil, fail:((Error?) -> Void)? = nil) {
        switch target.method {
        case .get:
            ly_getRequest(target: target, param: param, header: target.headers, success: success, incorrect: incorrect, fail: fail)
        case .post:
            ly_postRequest(target: target, param: param, header: target.headers, success: success, incorrect: incorrect, fail: fail)
        }
    }
//    // MARK: === 查找本地缓存数据
//    func ly_LoaclCache(urlStr: String, param: Dictionary<String, Any>?) -> Dictionary<String, Any>? {
//        return LYNetWorkRequest.ly_loadCacheDataWith(urlStr: urlStr, dict: param)
//    }
//    // MARK: === 上传文件
//    func ly_Upload(imgData:Data, urlStr: String) {
//        LYNetWorkRequest.ly_uploadPhoto(imgData: imgData, urlStr: urlStr, success: { [weak self](response) in
//            self?.p_callDelegate(success: urlStr, data: response)
//        }) { [weak self](error) in
//            self?.p_callDelegate(fail: urlStr, error: error)
//        }
//    }
//    // MARK: === 下载文件
//    func ly_down(filePath path: String, progress: ((Progress, String) -> Void)?, success: ((URL?) -> Void)?) -> Void {
//        _ = LYNetWorkRequest.ly_downloadFile(atPath: path, downProgress: progress, success: success)
//    }
}

extension LYNetProvider {
    fileprivate func ly_getRequest(target:Target, param: [String: Any]?, header:[String: String], success:(([String: Any]?) -> Void)?, incorrect:((String, String) -> Void)?, fail:((Error?) -> Void)?) {
        requestsArr.append(LYNetWorkRequest.ly_getRequest(urlStr: target.urlStr, dict: param, isCache: target.needCache, success: { (responseObj) in
            //  LYToastView.hideLoading()
            success?(responseObj)
        }, notSuccess: { (code, msg) in
            //  LYToastView.hideLoading()
            incorrect?(code, msg)
        }) { (error) in
            //  LYToastView.hideLoading()
            fail?(error)
        })
    }
    
    ///  post request
    fileprivate func ly_postRequest(target:Target, param: [String: Any]?, header:[String: String], success:(([String: Any]?) -> Void)?, incorrect:((String, String) -> Void)?, fail:((Error?) -> Void)?) {
        requestsArr.append(LYNetWorkRequest.ly_postRequest(urlStr: target.urlStr, dict: param, isCache: target.needCache, success: { (responseObj) in
            //  LYToastView.hideLoading()
            success?(responseObj)
        }, notSuccess: { (code, msg) in
            //  LYToastView.hideLoading()
            incorrect?(code, msg)
        }) { (error) in
            //  LYToastView.hideLoading()
            fail?(error)
        })
    }
}

public protocol LYNetTargetType {
    
    /// The target's base `URL`.
    var baseURL: String { get }
    
    /// The path to be appended to `baseURL` to form the full `URL`.
    var path: String { get }
    
    /// baseURL + path
    var urlStr: String { get }
    
    /// The HTTP method used in the request.
    var method: LYHTTPMethod { get }
    
    /// Cache dict to disk
    var needCache: Bool { get }
    
    /// The headers to be used in the request.
    var headers: [String: String] { get }
}

public enum LYHTTPMethod {
    case get
    case post
}



