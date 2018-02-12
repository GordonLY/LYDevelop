//
//  UIViewRefreshExtension.swift
//  kemiBear
//
//  Created by 李扬 on 2017/2/22.
//  Copyright © 2017年 lanrun. All rights reserved.
//

import UIKit
import MJRefresh

extension LYDevelop where Base: UITableView {
    
    ///  给 tableView 添加 refreshHeader
    func addTableViewHeader(block:@escaping () -> Void) {
        let header = LYRefreshHeader(refreshingBlock: block)
        p_setRefreshHeader(header!)
        base.mj_header = header
    }
    ///  给 tableView 添加 refreshFooter
    func addTableViewFooter(block:@escaping () -> Void) {
        let footer = LYRefreshFooter(refreshingBlock: block)
        p_setRefreshFooter(footer!)
        base.mj_footer = footer
    }
    /// set footer title
    func setTitle(_ title:String?, for state: MJRefreshState) -> Void {
        guard let footer = base.mj_footer as? LYRefreshFooter else { return }
        footer.setTitle(title, for: state)
    }
    // MARK: - ********* Private Method
    private func p_setRefreshHeader(_ header:LYRefreshHeader) {
        header.isAutomaticallyChangeAlpha = true
    }
    private func p_setRefreshFooter(_ footer:LYRefreshFooter) {
        
    }
}

extension LYDevelop where Base: UICollectionView {
    
    ///  给 collectionView 添加 refreshHeader
    func addCollectionViewHeader(block:@escaping () -> Void) {
        let header = LYRefreshHeader(refreshingBlock: block)
        p_setRefreshHeader(header!)
        base.mj_header = header
    }
    ///  给 collectionView 添加 refreshFooter
    func addCollectionViewFooter(block:@escaping () -> Void) {
        let footer = LYRefreshFooter(refreshingBlock: block)
        p_setRefreshFooter(footer!)
        base.mj_footer = footer
    }
    /// set footer title
    func setTitle(_ title:String?, for state: MJRefreshState) -> Void {
        guard let footer = base.mj_footer as? LYRefreshFooter else { return }
        footer.setTitle(title, for: state)
    }
    // MARK: - ********* Private Method
    private func p_setRefreshHeader(_ header:LYRefreshHeader) {
        header.isAutomaticallyChangeAlpha = true
    }
    private func p_setRefreshFooter(_ footer:LYRefreshFooter) {
        
    }
}


