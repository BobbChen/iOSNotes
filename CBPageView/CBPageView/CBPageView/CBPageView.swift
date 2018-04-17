//
//  CBPageView.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class CBPageView: UIView {
    // 在初始化之前需要将所有属性赋默认值
    fileprivate var titles: [String]
    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    fileprivate var titleStyle: CBTitleStyle
    
    fileprivate var titleView : CBTitleView!
    
    /// 初始化CHPageView
    ///
    /// - Parameters:
    ///   - frame: frame
    ///   - titles: 标题数组
    ///   - childVcs: 子控制器数组
    ///   - parentVc: 父控制器
    init(frame: CGRect, titles: [String], childVcs: [UIViewController], parentVc: UIViewController, titleStyle: CBTitleStyle) {
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.titleStyle = titleStyle
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
// MARK: - 设置UI
extension CBPageView{
    fileprivate func setUI() {
        setTitleView()
        setContentView()
    }
    
    fileprivate func setTitleView() {
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: titleStyle.titleViewH)
        titleView = CBTitleView(frame: titleViewFrame, titles: titles)
        titleView.backgroundColor = UIColor.randomColor()
        addSubview(titleView)
        
    }
    fileprivate func setContentView() {
        let contentViewFrame = CGRect(x: 0, y: titleView.frame.maxY, width: bounds.width, height: bounds.height - titleView.bounds.height)
        let contentView = CBContentView(frame: contentViewFrame, childVcs: childVcs, parentVc: parentVc)
        contentView.backgroundColor = UIColor.randomColor()
        addSubview(contentView)
    }
}
