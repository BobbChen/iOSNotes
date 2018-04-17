//
//  ViewController.swift
//  CBPageView
//
//  Created by 陈博 on 2018/4/16.
//  Copyright © 2018年 陈博. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titles = ["关注推","推荐","热点","北京热点","视频","新时代","北京","视频","新时代","新时代热点","视频","新时代热点"]
        var childVcs = [UIViewController]()
        for _ in 0..<titles.count {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVcs.append(vc)
        }
        
        let pageFrame = CGRect(x: 0, y: 64, width: view.bounds.width, height: view.bounds.height - 64)
        
        let titleStyle = CBTitleStyle()
        titleStyle.isScrollEnable = true
        let pageView = CBPageView(frame: pageFrame, titles: titles, childVcs: childVcs, parentVc: self, titleStyle: titleStyle)
        view .addSubview(pageView)
    }


}

