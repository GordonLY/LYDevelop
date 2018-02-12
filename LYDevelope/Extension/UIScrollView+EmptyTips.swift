//
//  UIScrollView+EmptyTips.swift
//  泰行销
//
//  Created by Gordon on 2017/10/27.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

import UIKit

enum EmptyType: String {
    case noData = "noDataImageName"
    case error = "errorImageName"
}

private var emptyViewkey: Void?
private var errorViewkey: Void?

extension LYDevelop where Base: UIScrollView {
    
    fileprivate var emptyView: LYEmptyView? {
        return objc_getAssociatedObject(base, &emptyViewkey) as? LYEmptyView
    }
    fileprivate var errorView: LYEmptyView? {
        return objc_getAssociatedObject(base, &errorViewkey) as? LYEmptyView
    }
    func setEmpty(tips: NSAttributedString, callBack: (() -> Void)? = nil) {
        let view = LYEmptyView.init(frame: base.bounds, tips: tips, type: .noData, onClick: callBack)
        view.backgroundColor = base.backgroundColor
        base.addSubview(view)
        base.bringSubview(toFront: view)
        view.isHidden = true
        objc_setAssociatedObject(base, &emptyViewkey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    func setError(tips: NSAttributedString, callBack: (() -> Void)? = nil) {
        let view = LYEmptyView.init(frame: base.bounds, tips: tips, type: .error, onClick: callBack)
        view.backgroundColor = base.backgroundColor
        base.addSubview(view)
        base.bringSubview(toFront: view)
        view.isHidden = true
        objc_setAssociatedObject(base, &errorViewkey, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    func ly_empty(atPoint point: CGPoint) {
        guard let view = emptyView else {
            return
        }
        view.btn.ly_origin = point
    }
}

extension LYDevelop where Base: UITableView {
    /// 使用此方法来reloadData, reload完成后会根据数据源是否为空来显示emptyView
    func reloadData() {
        base.reloadData()
        errorView?.isHidden = true
        guard let emptyView = emptyView else { return }
        var isEmpty = true
        for row in 0 ..< base.numberOfSections {
            if base.numberOfRows(inSection: row) > 0 {
                isEmpty = false
                break
            }
        }
        emptyView.isHidden = !isEmpty
    }
    func showError() {
        guard let errorView = errorView else { return }
        errorView.superview?.bringSubview(toFront: errorView)
        errorView.isHidden = false
    }
}
extension LYDevelop where Base: UICollectionView {
    /// 使用此方法来reloadData, reload完成后会根据数据源是否为空来显示emptyView
    func reloadData() {
        base.reloadData()
        errorView?.isHidden = true
        guard let emptyView = emptyView else { return }
        var isEmpty = true
        for item in 0 ..< base.numberOfSections {
            if base.numberOfItems(inSection: item) > 0 {
                isEmpty = false
                break
            }
        }
        emptyView.isHidden = !isEmpty
    }
    func showError() {
        guard let errorView = errorView else { return }
        errorView.superview?.bringSubview(toFront: errorView)
        errorView.isHidden = false
    }
}

final class LYEmptyView: UIView {
    
    fileprivate var type : EmptyType
    fileprivate var tips : NSAttributedString
    fileprivate var tipsOnClick: (() -> Void)?
    
    fileprivate var btn: LYFrameButton!
    private let imgMarginTitle = kFitCeilWid(12)
    
    @objc private func p_actionTipsBtn() {
        tipsOnClick?()
    }
    
    init(frame: CGRect, tips: NSAttributedString, type: EmptyType, onClick: (() -> Void)? = nil) {
        self.type = type
        self.tips = tips
        self.tipsOnClick = onClick
        super.init(frame: frame)
        
        let image = UIImage(named: type.rawValue)
        let imgHei = image?.size.height ?? 0
        let titleHei = tips.size().height
        let btnHei = imgHei + titleHei + imgMarginTitle
        
        btn = LYFrameButton().then {
            $0.frame = CGRect(x: 0, y: 0, width: self.width, height: btnHei)
            $0.center = CGPoint.init(x: self.middleX, y: self.middleY)
            $0.lyImageViewFrame = CGRect(x: 0, y: 0, width: btn.width, height: imgHei)
            $0.lyTitleLabelFrame = CGRect(x: 0, y: btn.height - titleHei, width: btn.width, height: titleHei)
            $0.imageView?.contentMode = .scaleAspectFit
            $0.titleLabel?.textAlignment = .center
            $0.setImage(image, for: .normal)
            $0.setAttributedTitle(tips, for: .normal)
            $0.addTarget(self, action: #selector(p_actionTipsBtn), for: .touchUpInside)
            self.addSubview($0)
            $0.isUserInteractionEnabled = onClick != nil
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
